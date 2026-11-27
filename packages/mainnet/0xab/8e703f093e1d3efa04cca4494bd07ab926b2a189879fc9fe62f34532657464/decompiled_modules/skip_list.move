module 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list {
    struct SkipList<phantom T0: store> has store, key {
        id: 0x2::object::UID,
        head: vector<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>,
        tail: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64,
        level: u64,
        max_level: u64,
        list_p: u64,
        size: u64,
        random: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::random::Random,
    }

    struct Node<T0: store> has store {
        score: u64,
        nexts: vector<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>,
        prev: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64,
        value: T0,
    }

    struct Item has drop, store {
        n: u64,
        score: u64,
        finded: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64,
    }

    struct BitmapStateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct BitmapWordKey has copy, drop, store {
        level: u8,
        word_index: u64,
    }

    struct BitmapState has copy, drop, store {
        format_version: u64,
        mode: u8,
        min_score: u64,
        max_score: u64,
        stride: u64,
        universe_size: u64,
        depth: u8,
        indexed_size: u64,
        snapshot_size: u64,
        snapshot_head: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64,
        snapshot_tail: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64,
        cursor: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64,
        last_score: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64,
        cleanup_level: u8,
        cleanup_word_index: u64,
    }

    public fun length<T0: store>(arg0: &SkipList<T0>) : u64 {
        arg0.size
    }

    public fun borrow<T0: store>(arg0: &SkipList<T0>, arg1: u64) : &T0 {
        &0x2::dynamic_field::borrow<u64, Node<T0>>(&arg0.id, arg1).value
    }

    public fun borrow_mut<T0: store>(arg0: &mut SkipList<T0>, arg1: u64) : &mut T0 {
        assert_bitmap_available<T0>(arg0);
        &mut 0x2::dynamic_field::borrow_mut<u64, Node<T0>>(&mut arg0.id, arg1).value
    }

    public fun destroy_empty<T0: drop + store>(arg0: SkipList<T0>) {
        if (checked_bitmap_mode<T0>(&arg0) == 3) {
            bitmap_health<T0>(&arg0);
            assert!(arg0.size == 0, 3);
            let v0 = BitmapStateKey{dummy_field: false};
            0x2::dynamic_field::remove<BitmapStateKey, BitmapState>(&mut arg0.id, v0);
        };
        let SkipList {
            id        : v1,
            head      : _,
            tail      : _,
            level     : _,
            max_level : _,
            list_p    : _,
            size      : v7,
            random    : _,
        } = arg0;
        assert!(v7 == 0, 3);
        0x2::object::delete(v1);
    }

    public fun is_empty<T0: store>(arg0: &SkipList<T0>) : bool {
        arg0.size == 0
    }

    public fun remove<T0: store>(arg0: &mut SkipList<T0>, arg1: u64) : T0 {
        if (checked_bitmap_mode<T0>(arg0) == 3) {
            return bitmap_remove<T0>(arg0, arg1)
        };
        assert!(contains<T0>(arg0, arg1), 1);
        let v0 = &mut arg0.head;
        let v1 = arg0.level;
        let v2 = 0x2::dynamic_field::remove<u64, Node<T0>>(&mut arg0.id, arg1);
        while (v1 > 0) {
            let v3 = 0x1::vector::borrow_mut<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>(v0, v1 - 1);
            while (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some_and_lte(v3, arg1)) {
                let v4 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(v3);
                if (v4 == arg1) {
                    *v3 = *0x1::vector::borrow<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>(&v2.nexts, v1 - 1);
                    continue
                };
                let v5 = borrow_mut_node<T0>(arg0, v4);
                let v6 = &mut v5.nexts;
                v0 = v6;
                v3 = 0x1::vector::borrow_mut<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>(v6, v1 - 1);
            };
            v1 = v1 - 1;
        };
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&arg0.tail) == arg1) {
            arg0.tail = v2.prev;
        };
        let v7 = 0x1::vector::borrow<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>(&v2.nexts, 0);
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(v7)) {
            let v8 = borrow_mut_node<T0>(arg0, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(v7));
            v8.prev = v2.prev;
        };
        arg0.size = arg0.size - 1;
        drop_node<T0>(v2)
    }

    public fun new<T0: store>(arg0: u64, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : SkipList<T0> {
        assert!(arg1 > 1, 5);
        assert!(arg0 > 0, 6);
        SkipList<T0>{
            id        : 0x2::object::new(arg3),
            head      : 0x1::vector::empty<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>(),
            tail      : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::none(),
            level     : 0,
            max_level : arg0,
            list_p    : arg1,
            size      : 0,
            random    : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::random::new(arg2),
        }
    }

    fun ceil256(arg0: u64) : u64 {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::bitmap_math::ceil256(arg0)
    }

    fun level_bits(arg0: &BitmapState, arg1: u8) : u64 {
        assert!(arg1 < arg0.depth, 12);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::bitmap_math::level_bits(arg0.universe_size, arg1)
    }

    public fun assert_bitmap_available<T0: store>(arg0: &SkipList<T0>) {
        checked_bitmap_mode<T0>(arg0);
    }

    fun base_head<T0: store>(arg0: &SkipList<T0>) : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64 {
        if (0x1::vector::is_empty<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>(&arg0.head)) {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::none()
        } else {
            *0x1::vector::borrow<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>(&arg0.head, 0)
        }
    }

    public fun bitmap_begin<T0: store>(arg0: &mut SkipList<T0>, arg1: u64, arg2: u64, arg3: u64) {
        assert!(bitmap_mode<T0>(arg0) == 0, 10);
        bitmap_endpoints<T0>(arg0);
        let (v0, v1) = bitmap_config(arg1, arg2, arg3);
        let v2 = base_head<T0>(arg0);
        let v3 = BitmapState{
            format_version     : 1,
            mode               : 1,
            min_score          : arg1,
            max_score          : arg2,
            stride             : arg3,
            universe_size      : v0,
            depth              : v1,
            indexed_size       : 0,
            snapshot_size      : arg0.size,
            snapshot_head      : v2,
            snapshot_tail      : arg0.tail,
            cursor             : v2,
            last_score         : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::none(),
            cleanup_level      : 0,
            cleanup_word_index : 0,
        };
        let v4 = BitmapStateKey{dummy_field: false};
        0x2::dynamic_field::add<BitmapStateKey, BitmapState>(&mut arg0.id, v4, v3);
    }

    public fun bitmap_build_step<T0: store>(arg0: &mut SkipList<T0>) {
        let v0 = bitmap_snapshot<T0>(arg0);
        assert!(v0.mode == 1 || v0.mode == 5, 10);
        assert!(v0.indexed_size < v0.snapshot_size && 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v0.cursor), 12);
        let v1 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v0.cursor);
        let v2 = checked_node<T0>(arg0, v1);
        assert!(v2.prev == v0.last_score, 12);
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v0.last_score)) {
            assert!(v1 > 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v0.last_score), 12);
        };
        let v3 = next_score<T0>(v2);
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v3)) {
            assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v3) > v1, 12);
        };
        bitmap_set<T0>(arg0, v1, true);
        let v4 = BitmapStateKey{dummy_field: false};
        let v5 = 0x2::dynamic_field::borrow_mut<BitmapStateKey, BitmapState>(&mut arg0.id, v4);
        v5.indexed_size = v5.indexed_size + 1;
        v5.last_score = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::some(v1);
        v5.cursor = v3;
    }

    public fun bitmap_cancel_batch<T0: store>(arg0: &mut SkipList<T0>, arg1: u64) {
        bitmap_cleanup<T0>(arg0, arg1, false);
    }

    public fun bitmap_cancel_begin<T0: store>(arg0: &mut SkipList<T0>) {
        let v0 = bitmap_snapshot<T0>(arg0);
        assert!(v0.mode == 1, 10);
        let v1 = BitmapStateKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<BitmapStateKey, BitmapState>(&mut arg0.id, v1);
        v2.mode = 2;
        v2.cleanup_level = 0;
        v2.cleanup_word_index = 0;
    }

    public fun bitmap_cancel_finish<T0: store>(arg0: &mut SkipList<T0>) {
        let v0 = bitmap_snapshot<T0>(arg0);
        let v1 = if (v0.mode == 2) {
            if (v0.cleanup_level == v0.depth) {
                v0.cleanup_word_index == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 10);
        let v2 = BitmapStateKey{dummy_field: false};
        0x2::dynamic_field::remove<BitmapStateKey, BitmapState>(&mut arg0.id, v2);
    }

    public fun bitmap_check_limit(arg0: u64) {
        assert!(arg0 > 0 && arg0 <= 128, 14);
    }

    public fun bitmap_check_mapping<T0: store>(arg0: &SkipList<T0>, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = bitmap_state<T0>(arg0);
        let v1 = if (v0.min_score == arg1) {
            if (v0.max_score == arg2) {
                v0.stride == arg3
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 11);
    }

    public fun bitmap_checked_neighbor<T0: store>(arg0: &SkipList<T0>, arg1: u64, arg2: bool) : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64 {
        let v0 = borrow_node<T0>(arg0, arg1);
        if (checked_bitmap_mode<T0>(arg0) == 0) {
            return if (arg2) {
                next_score<T0>(v0)
            } else {
                v0.prev
            }
        };
        check_node_ref<T0>(arg0, arg1, v0);
        checked_neighbor_from_node<T0>(arg0, v0, arg2)
    }

    fun bitmap_cleanup<T0: store>(arg0: &mut SkipList<T0>, arg1: u64, arg2: bool) {
        bitmap_check_limit(arg1);
        let v0 = bitmap_snapshot<T0>(arg0);
        let v1 = if (arg2) {
            4
        } else {
            2
        };
        assert!(v0.mode == v1, 10);
        let v2 = v0.cleanup_level;
        let v3 = v2;
        let v4 = v0.cleanup_word_index;
        let v5 = if (v2 < v0.depth) {
            ceil256(level_bits(&v0, v2))
        } else {
            0
        };
        let v6 = v5;
        let v7 = 0;
        while (v3 < v0.depth && v7 < arg1) {
            let v8 = BitmapWordKey{
                level      : v3,
                word_index : v4,
            };
            if (0x2::dynamic_field::exists_<BitmapWordKey>(&arg0.id, v8)) {
                0x2::dynamic_field::remove<BitmapWordKey, u256>(&mut arg0.id, v8);
            };
            v7 = v7 + 1;
            let v9 = v4 + 1;
            v4 = v9;
            if (v9 == v6) {
                let v10 = v3 + 1;
                v3 = v10;
                v4 = 0;
                if (v10 < v0.depth) {
                    v6 = ceil256(level_bits(&v0, v10));
                };
            };
        };
        let v11 = BitmapStateKey{dummy_field: false};
        let v12 = 0x2::dynamic_field::borrow_mut<BitmapStateKey, BitmapState>(&mut arg0.id, v11);
        v12.cleanup_level = v3;
        v12.cleanup_word_index = v4;
    }

    public fun bitmap_cleanup_done<T0: store>(arg0: &SkipList<T0>) : bool {
        let v0 = bitmap_state<T0>(arg0);
        v0.cleanup_level == v0.depth
    }

    fun bitmap_config(arg0: u64, arg1: u64, arg2: u64) : (u64, u8) {
        let v0 = if (arg2 > 0) {
            if (arg0 <= arg1) {
                (arg1 - arg0) % arg2 == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 11);
        let v1 = (arg1 - arg0) / arg2;
        assert!(v1 < 16777216, 11);
        let v2 = v1 + 1;
        (v2, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::bitmap_math::depth(v2))
    }

    public fun bitmap_cursor<T0: store>(arg0: &SkipList<T0>) : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64 {
        let v0 = bitmap_snapshot<T0>(arg0);
        assert!(v0.mode == 1 || v0.mode == 5, 10);
        v0.cursor
    }

    fun bitmap_endpoints<T0: store>(arg0: &SkipList<T0>) {
        let v0 = base_head<T0>(arg0);
        if (arg0.size == 0) {
            assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_none(&v0) && 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_none(&arg0.tail), 12);
        } else {
            assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v0) && 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&arg0.tail), 12);
        };
    }

    public fun bitmap_finalize<T0: store>(arg0: &mut SkipList<T0>) {
        bitmap_finish<T0>(arg0, false);
    }

    fun bitmap_find<T0: store>(arg0: &SkipList<T0>, arg1: u64, arg2: bool, arg3: bool) : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64 {
        let v0 = bitmap_health<T0>(arg0);
        let v1 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::none();
        if (arg3) {
            if (arg1 < v0.max_score || arg2 && arg1 == v0.max_score) {
                let v2 = if (arg2) {
                    arg1
                } else {
                    arg1 + 1
                };
                let v3 = if (v2 < v0.min_score) {
                    v0.min_score
                } else {
                    v2
                };
                let v4 = v3 - v0.min_score;
                let v5 = if (v4 % v0.stride == 0) {
                    0
                } else {
                    1
                };
                v1 = bitmap_search<T0>(arg0, &v0, v4 / v0.stride + v5, true);
            };
        } else if (arg1 > v0.min_score || arg2 && arg1 == v0.min_score) {
            let v6 = if (arg2) {
                arg1
            } else {
                arg1 - 1
            };
            let v7 = if (v6 > v0.max_score) {
                v0.max_score
            } else {
                v6
            };
            v1 = bitmap_search<T0>(arg0, &v0, (v7 - v0.min_score) / v0.stride, false);
        };
        bitmap_validate_result<T0>(arg0, arg1, arg2, arg3, v1);
        v1
    }

    fun bitmap_finish<T0: store>(arg0: &mut SkipList<T0>, arg1: bool) {
        let v0 = bitmap_snapshot<T0>(arg0);
        let v1 = if (arg1) {
            5
        } else {
            1
        };
        assert!(v0.mode == v1, 10);
        let v2 = if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_none(&v0.cursor)) {
            if (v0.last_score == v0.snapshot_tail) {
                v0.indexed_size == v0.snapshot_size
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 12);
        bitmap_endpoints<T0>(arg0);
        assert!(bitmap_word<T0>(arg0, &v0, v0.depth - 1, 0) == 0 == arg0.size == 0, 12);
        let v3 = 0;
        while (v3 < v0.depth) {
            bitmap_word<T0>(arg0, &v0, v3, ceil256(level_bits(&v0, v3)) - 1);
            v3 = v3 + 1;
        };
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v0.snapshot_head)) {
            assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_none(&checked_node<T0>(arg0, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v0.snapshot_head)).prev), 12);
            let v4 = next_score<T0>(checked_node<T0>(arg0, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v0.snapshot_tail)));
            assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_none(&v4), 12);
        };
        if (!arg1) {
            let v5 = 0x1::vector::empty<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>();
            0x1::vector::push_back<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>(&mut v5, v0.snapshot_head);
            arg0.head = v5;
            arg0.level = 1;
        } else {
            assert!(arg0.level == 1 && 0x1::vector::length<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>(&arg0.head) == 1, 12);
        };
        let v6 = BitmapStateKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<BitmapStateKey, BitmapState>(&mut arg0.id, v6).mode = 3;
        bitmap_health<T0>(arg0);
    }

    fun bitmap_health<T0: store>(arg0: &SkipList<T0>) : BitmapState {
        let v0 = *bitmap_state<T0>(arg0);
        assert!(v0.mode == 3 && v0.indexed_size == arg0.size, 12);
        assert!(arg0.level == 1 && 0x1::vector::length<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>(&arg0.head) == 1, 12);
        bitmap_endpoints<T0>(arg0);
        assert!(bitmap_word<T0>(arg0, &v0, v0.depth - 1, 0) == 0 == arg0.size == 0, 12);
        v0
    }

    fun bitmap_insert<T0: store>(arg0: &mut SkipList<T0>, arg1: u64, arg2: T0) {
        assert!(!contains<T0>(arg0, arg1), 0);
        let v0 = *bitmap_state<T0>(arg0);
        bitmap_q(&v0, arg1);
        let v1 = bitmap_find<T0>(arg0, arg1, false, false);
        let v2 = bitmap_find<T0>(arg0, arg1, false, true);
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v1)) {
            assert!(next_score<T0>(checked_node<T0>(arg0, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v1))) == v2, 12);
        } else {
            assert!(base_head<T0>(arg0) == v2, 12);
        };
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v2)) {
            assert!(checked_node<T0>(arg0, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v2)).prev == v1, 12);
        } else {
            assert!(arg0.tail == v1, 12);
        };
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v1)) {
            *0x1::vector::borrow_mut<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>(&mut 0x2::dynamic_field::borrow_mut<u64, Node<T0>>(&mut arg0.id, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v1)).nexts, 0) = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::some(arg1);
        } else {
            *0x1::vector::borrow_mut<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>(&mut arg0.head, 0) = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::some(arg1);
        };
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v2)) {
            0x2::dynamic_field::borrow_mut<u64, Node<T0>>(&mut arg0.id, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v2)).prev = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::some(arg1);
        } else {
            arg0.tail = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::some(arg1);
        };
        let v3 = 0x1::vector::empty<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>();
        0x1::vector::push_back<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>(&mut v3, v2);
        let v4 = Node<T0>{
            score : arg1,
            nexts : v3,
            prev  : v1,
            value : arg2,
        };
        0x2::dynamic_field::add<u64, Node<T0>>(&mut arg0.id, arg1, v4);
        bitmap_set<T0>(arg0, arg1, true);
        arg0.size = arg0.size + 1;
        let v5 = BitmapStateKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<BitmapStateKey, BitmapState>(&mut arg0.id, v5).indexed_size = v0.indexed_size + 1;
        bitmap_health<T0>(arg0);
    }

    public fun bitmap_mode<T0: store>(arg0: &SkipList<T0>) : u8 {
        let v0 = BitmapStateKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<BitmapStateKey>(&arg0.id, v0)) {
            0
        } else {
            bitmap_state<T0>(arg0).mode
        }
    }

    fun bitmap_q(arg0: &BitmapState, arg1: u64) : u64 {
        assert!(arg1 >= arg0.min_score && arg1 <= arg0.max_score, 11);
        assert!((arg1 - arg0.min_score) % arg0.stride == 0, 11);
        (arg1 - arg0.min_score) / arg0.stride
    }

    fun bitmap_remove<T0: store>(arg0: &mut SkipList<T0>, arg1: u64) : T0 {
        bitmap_health<T0>(arg0);
        let v0 = bitmap_checked_neighbor<T0>(arg0, arg1, false);
        let v1 = bitmap_checked_neighbor<T0>(arg0, arg1, true);
        bitmap_set<T0>(arg0, arg1, false);
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v0)) {
            *0x1::vector::borrow_mut<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>(&mut 0x2::dynamic_field::borrow_mut<u64, Node<T0>>(&mut arg0.id, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v0)).nexts, 0) = v1;
        } else {
            *0x1::vector::borrow_mut<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>(&mut arg0.head, 0) = v1;
        };
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v1)) {
            0x2::dynamic_field::borrow_mut<u64, Node<T0>>(&mut arg0.id, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v1)).prev = v0;
        } else {
            arg0.tail = v0;
        };
        arg0.size = arg0.size - 1;
        let v2 = BitmapStateKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<BitmapStateKey, BitmapState>(&mut arg0.id, v2);
        v3.indexed_size = v3.indexed_size - 1;
        bitmap_health<T0>(arg0);
        drop_node<T0>(0x2::dynamic_field::remove<u64, Node<T0>>(&mut arg0.id, arg1))
    }

    public fun bitmap_repair_begin<T0: store>(arg0: &mut SkipList<T0>) {
        assert!(bitmap_mode<T0>(arg0) == 3, 10);
        assert!(arg0.level == 1 && 0x1::vector::length<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>(&arg0.head) == 1, 12);
        bitmap_endpoints<T0>(arg0);
        let v0 = BitmapStateKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<BitmapStateKey, BitmapState>(&mut arg0.id, v0);
        v1.mode = 4;
        v1.snapshot_size = arg0.size;
        v1.snapshot_head = base_head<T0>(arg0);
        v1.snapshot_tail = arg0.tail;
        v1.cleanup_level = 0;
        v1.cleanup_word_index = 0;
    }

    public fun bitmap_repair_clear_batch<T0: store>(arg0: &mut SkipList<T0>, arg1: u64) {
        bitmap_cleanup<T0>(arg0, arg1, true);
    }

    public fun bitmap_repair_clear_finish<T0: store>(arg0: &mut SkipList<T0>) {
        bitmap_snapshot<T0>(arg0);
        let v0 = BitmapStateKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<BitmapStateKey, BitmapState>(&mut arg0.id, v0);
        let v2 = if (v1.mode == 4) {
            if (v1.cleanup_level == v1.depth) {
                v1.cleanup_word_index == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 10);
        v1.mode = 5;
        v1.indexed_size = 0;
        v1.cursor = v1.snapshot_head;
        v1.last_score = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::none();
    }

    public fun bitmap_repair_finalize<T0: store>(arg0: &mut SkipList<T0>) {
        bitmap_finish<T0>(arg0, true);
    }

    public fun bitmap_repair_restart<T0: store>(arg0: &mut SkipList<T0>) {
        let v0 = bitmap_snapshot<T0>(arg0);
        assert!(v0.mode == 5, 10);
        let v1 = BitmapStateKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<BitmapStateKey, BitmapState>(&mut arg0.id, v1);
        v2.mode = 4;
        v2.cleanup_level = 0;
        v2.cleanup_word_index = 0;
    }

    fun bitmap_search<T0: store>(arg0: &SkipList<T0>, arg1: &BitmapState, arg2: u64, arg3: bool) : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64 {
        let v0 = 0;
        loop {
            if (arg2 >= level_bits(arg1, v0)) {
                return 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::none()
            };
            let v1 = arg2 / 256;
            let v2 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::bitmap_math::directional_mask(bitmap_word<T0>(arg0, arg1, v0, v1), ((arg2 % 256) as u8), arg3);
            if (v2 != 0) {
                arg2 = v1 * 256 + 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::bitmap_math::extreme_bit(v2, arg3);
                while (v0 > 0) {
                    let v3 = v0 - 1;
                    v0 = v3;
                    let v4 = bitmap_word<T0>(arg0, arg1, v3, arg2);
                    assert!(v4 != 0, 12);
                    let v5 = arg2 * 256;
                    arg2 = v5 + 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::bitmap_math::extreme_bit(v4, arg3);
                };
                assert!(arg2 < arg1.universe_size, 12);
                return 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::some(arg1.min_score + arg2 * arg1.stride)
            };
            let v6 = v0 + 1;
            v0 = v6;
            if (v6 == arg1.depth) {
                return 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::none()
            };
            if (arg3) {
                arg2 = v1 + 1;
                continue
            };
            if (v1 == 0) {
                break
            };
            arg2 = v1 - 1;
        };
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::none()
    }

    fun bitmap_set<T0: store>(arg0: &mut SkipList<T0>, arg1: u64, arg2: bool) {
        let v0 = *bitmap_state<T0>(arg0);
        let v1 = bitmap_q(&v0, arg1);
        let v2 = 0;
        loop {
            v1 = v1 / 256;
            let v3 = 1 << ((v1 % 256) as u8);
            let v4 = bitmap_word<T0>(arg0, &v0, v2, v1);
            assert!(v4 & v3 != 0 != arg2, 12);
            let v5 = if (arg2) {
                v4 | v3
            } else {
                v4 ^ v3
            };
            write_word<T0>(arg0, v2, v1, v5);
            v2 = v2 + 1;
            if (v2 == v0.depth || v4 != 0 && v5 != 0) {
                break
            };
        };
    }

    fun bitmap_snapshot<T0: store>(arg0: &SkipList<T0>) : BitmapState {
        let v0 = *bitmap_state<T0>(arg0);
        let v1 = if (arg0.size == v0.snapshot_size) {
            if (base_head<T0>(arg0) == v0.snapshot_head) {
                arg0.tail == v0.snapshot_tail
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 12);
        v0
    }

    fun bitmap_state<T0: store>(arg0: &SkipList<T0>) : &BitmapState {
        let v0 = BitmapStateKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<BitmapStateKey, BitmapState>(&arg0.id, v0);
        let v2 = if (v1.format_version == 1) {
            if (v1.mode >= 1) {
                v1.mode <= 5
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 10);
        let (v3, v4) = bitmap_config(v1.min_score, v1.max_score, v1.stride);
        assert!(v3 == v1.universe_size && v4 == v1.depth, 11);
        v1
    }

    public fun bitmap_status<T0: store>(arg0: &SkipList<T0>) : (u8, u64, u64, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64, u8, u64) {
        let v0 = bitmap_mode<T0>(arg0);
        if (v0 == 0) {
            return (0, 0, 0, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::none(), 0, 0)
        };
        let v1 = bitmap_state<T0>(arg0);
        (v0, v1.snapshot_size, v1.indexed_size, v1.cursor, v1.cleanup_level, v1.cleanup_word_index)
    }

    fun bitmap_validate_result<T0: store>(arg0: &SkipList<T0>, arg1: u64, arg2: bool, arg3: bool, arg4: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64) {
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&arg4)) {
            let v0 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&arg4);
            let v1 = checked_node<T0>(arg0, v0);
            assert!(arg3 && (v0 > arg1 || arg2 && v0 == arg1) || v0 < arg1 || arg2 && v0 == arg1, 12);
            let v2 = checked_neighbor_from_node<T0>(arg0, v1, !arg3);
            if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_none(&v1.prev)) {
                assert!(base_head<T0>(arg0) == arg4, 12);
            };
            let v3 = next_score<T0>(v1);
            if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_none(&v3)) {
                assert!(arg0.tail == arg4, 12);
            };
            if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v2)) {
                let v4 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v2);
                assert!(arg3 && (v4 < arg1 || !arg2 && v4 == arg1) || v4 > arg1 || !arg2 && v4 == arg1, 12);
            };
        } else {
            let v5 = if (arg3) {
                arg0.tail
            } else {
                base_head<T0>(arg0)
            };
            let v6 = v5;
            if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v6)) {
                let v7 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v6);
                let v8 = if (arg3) {
                    next_score<T0>(checked_node<T0>(arg0, v7))
                } else {
                    checked_node<T0>(arg0, v7).prev
                };
                let v9 = v8;
                assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_none(&v9), 12);
                assert!(arg3 && (v7 < arg1 || !arg2 && v7 == arg1) || v7 > arg1 || !arg2 && v7 == arg1, 12);
            };
        };
    }

    fun bitmap_word<T0: store>(arg0: &SkipList<T0>, arg1: &BitmapState, arg2: u8, arg3: u64) : u256 {
        let v0 = level_bits(arg1, arg2);
        assert!(arg3 < ceil256(v0), 12);
        let (v1, v2) = raw_word<T0>(arg0, arg2, arg3);
        let v3 = v0 - arg3 * 256;
        if (v3 < 256) {
            assert!(v2 >> (v3 as u8) == 0, 12);
        };
        if (v1) {
            assert!(v2 != 0, 12);
        };
        v2
    }

    public fun borrow_mut_node<T0: store>(arg0: &mut SkipList<T0>, arg1: u64) : &mut Node<T0> {
        assert_bitmap_available<T0>(arg0);
        0x2::dynamic_field::borrow_mut<u64, Node<T0>>(&mut arg0.id, arg1)
    }

    public fun borrow_mut_value<T0: store>(arg0: &mut Node<T0>) : &mut T0 {
        &mut arg0.value
    }

    public fun borrow_node<T0: store>(arg0: &SkipList<T0>, arg1: u64) : &Node<T0> {
        0x2::dynamic_field::borrow<u64, Node<T0>>(&arg0.id, arg1)
    }

    public fun borrow_value<T0: store>(arg0: &Node<T0>) : &T0 {
        &arg0.value
    }

    fun check_node_ref<T0: store>(arg0: &SkipList<T0>, arg1: u64, arg2: &Node<T0>) {
        assert!(arg2.score == arg1 && !0x1::vector::is_empty<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>(&arg2.nexts), 12);
        bitmap_q(bitmap_state<T0>(arg0), arg1);
    }

    public fun checked_bitmap_mode<T0: store>(arg0: &SkipList<T0>) : u8 {
        let v0 = bitmap_mode<T0>(arg0);
        assert!(v0 == 0 || v0 == 3, 13);
        v0
    }

    fun checked_neighbor_from_node<T0: store>(arg0: &SkipList<T0>, arg1: &Node<T0>, arg2: bool) : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64 {
        let v0 = arg1.score;
        let v1 = if (arg2) {
            next_score<T0>(arg1)
        } else {
            arg1.prev
        };
        let v2 = v1;
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v2)) {
            let v3 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v2);
            let v4 = checked_node<T0>(arg0, v3);
            if (arg2) {
                assert!(v3 > v0 && v4.prev == 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::some(v0), 12);
            } else {
                assert!(v3 < v0 && next_score<T0>(v4) == 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::some(v0), 12);
            };
        } else {
            let v5 = if (arg2) {
                arg0.tail
            } else {
                base_head<T0>(arg0)
            };
            assert!(v5 == 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::some(v0), 12);
        };
        v2
    }

    fun checked_node<T0: store>(arg0: &SkipList<T0>, arg1: u64) : &Node<T0> {
        let v0 = borrow_node<T0>(arg0, arg1);
        check_node_ref<T0>(arg0, arg1, v0);
        v0
    }

    public fun contains<T0: store>(arg0: &SkipList<T0>, arg1: u64) : bool {
        0x2::dynamic_field::exists_with_type<u64, Node<T0>>(&arg0.id, arg1)
    }

    fun create_node<T0: store>(arg0: &mut SkipList<T0>, arg1: u64, arg2: T0) : (u64, Node<T0>) {
        let v0 = rand_level<T0>(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::random::rand(&mut arg0.random), arg0);
        if (v0 > arg0.level) {
            arg0.level = v0;
            0x1::vector::push_back<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>(&mut arg0.head, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::none());
        };
        let v1 = Node<T0>{
            score : arg1,
            nexts : 0x1::vector::empty<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>(),
            prev  : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::none(),
            value : arg2,
        };
        (v0, v1)
    }

    fun drop_node<T0: store>(arg0: Node<T0>) : T0 {
        let Node {
            score : _,
            nexts : _,
            prev  : _,
            value : v3,
        } = arg0;
        v3
    }

    fun find<T0: store>(arg0: &SkipList<T0>, arg1: u64) : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64 {
        if (checked_bitmap_mode<T0>(arg0) == 3) {
            let v0 = bitmap_find<T0>(arg0, arg1, true, false);
            return if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v0)) {
                v0
            } else {
                bitmap_find<T0>(arg0, arg1, true, true)
            }
        };
        find_legacy<T0>(arg0, arg1)
    }

    fun find_legacy<T0: store>(arg0: &SkipList<T0>, arg1: u64) : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64 {
        if (arg0.size == 0) {
            return 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::none()
        };
        let v0 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::none();
        let v1 = &arg0.head;
        let v2 = arg0.level;
        while (v2 > 0) {
            let v3 = *0x1::vector::borrow<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>(v1, v2 - 1);
            while (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some_and_lte(&v3, arg1)) {
                let v4 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v3);
                if (v4 == arg1) {
                    return 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::some(v4)
                };
                v0 = v3;
                let v5 = &borrow_node<T0>(arg0, v4).nexts;
                v1 = v5;
                v3 = *0x1::vector::borrow<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>(v5, v2 - 1);
            };
            if (v2 == 1 && 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v0)) {
                return v0
            };
            v2 = v2 - 1;
        };
        *0x1::vector::borrow<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>(&arg0.head, 0)
    }

    public fun find_next<T0: store>(arg0: &SkipList<T0>, arg1: u64, arg2: bool) : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64 {
        if (checked_bitmap_mode<T0>(arg0) == 3) {
            return bitmap_find<T0>(arg0, arg1, arg2, true)
        };
        let v0 = find_legacy<T0>(arg0, arg1);
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_none(&v0)) {
            return v0
        };
        let v1 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v0);
        if (arg2 && v1 == arg1 || v1 > arg1) {
            return v0
        };
        *0x1::vector::borrow<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>(&borrow_node<T0>(arg0, v1).nexts, 0)
    }

    public fun find_prev<T0: store>(arg0: &SkipList<T0>, arg1: u64, arg2: bool) : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64 {
        if (checked_bitmap_mode<T0>(arg0) == 3) {
            return bitmap_find<T0>(arg0, arg1, arg2, false)
        };
        let v0 = find_legacy<T0>(arg0, arg1);
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_none(&v0)) {
            return v0
        };
        let v1 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v0);
        if (arg2 && v1 == arg1 || v1 < arg1) {
            return v0
        };
        borrow_node<T0>(arg0, v1).prev
    }

    public fun head<T0: store>(arg0: &SkipList<T0>) : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64 {
        if (is_empty<T0>(arg0)) {
            return 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::none()
        };
        *0x1::vector::borrow<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>(&arg0.head, 0)
    }

    public fun insert<T0: store>(arg0: &mut SkipList<T0>, arg1: u64, arg2: T0) {
        if (checked_bitmap_mode<T0>(arg0) == 3) {
            bitmap_insert<T0>(arg0, arg1, arg2);
            return
        };
        assert!(!contains<T0>(arg0, arg1), 0);
        let (v0, v1) = create_node<T0>(arg0, arg1, arg2);
        let v2 = v1;
        let v3 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::none();
        let v4 = &mut arg0.head;
        let v5 = arg0.level;
        let v6 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::none();
        while (v5 > 0) {
            let v7 = 0x1::vector::borrow_mut<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>(v4, v5 - 1);
            while (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some_and_lte(v7, arg1)) {
                let v8 = 0x2::dynamic_field::borrow_mut<u64, Node<T0>>(&mut arg0.id, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(v7));
                v3 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::some(v8.score);
                let v9 = &mut v8.nexts;
                v4 = v9;
                v7 = 0x1::vector::borrow_mut<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>(v9, v5 - 1);
            };
            if (v0 >= v5) {
                0x1::vector::push_back<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>(&mut v2.nexts, *v7);
                if (v5 == 1) {
                    v2.prev = v3;
                    if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(v7)) {
                        v6 = *v7;
                    } else {
                        arg0.tail = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::some(arg1);
                    };
                };
                0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::swap_or_fill(v7, arg1);
            };
            v5 = v5 - 1;
        };
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v6)) {
            let v10 = borrow_mut_node<T0>(arg0, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v6));
            v10.prev = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::some(arg1);
        };
        0x1::vector::reverse<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>(&mut v2.nexts);
        0x2::dynamic_field::add<u64, Node<T0>>(&mut arg0.id, arg1, v2);
        arg0.size = arg0.size + 1;
    }

    public fun metadata<T0: store>(arg0: &SkipList<T0>) : (vector<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64, u64, u64, u64, u64) {
        (arg0.head, arg0.tail, arg0.level, arg0.max_level, arg0.list_p, arg0.size)
    }

    public fun next_score<T0: store>(arg0: &Node<T0>) : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64 {
        *0x1::vector::borrow<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64>(&arg0.nexts, 0)
    }

    public fun prev_score<T0: store>(arg0: &Node<T0>) : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64 {
        arg0.prev
    }

    fun rand_level<T0: store>(arg0: u64, arg1: &SkipList<T0>) : u64 {
        let v0 = 1;
        let v1 = arg1.list_p;
        while (arg0 % v1 == 0 && v0 < arg1.level + 1) {
            v1 = v1 * arg1.list_p;
            let v2 = v0 + 1;
            v0 = v2;
            if (v2 > arg1.level) {
                if (v2 >= arg1.max_level) {
                    v0 = arg1.max_level;
                    break
                } else {
                    v0 = arg1.level + 1;
                    break
                };
            };
        };
        v0
    }

    fun raw_word<T0: store>(arg0: &SkipList<T0>, arg1: u8, arg2: u64) : (bool, u256) {
        let v0 = BitmapWordKey{
            level      : arg1,
            word_index : arg2,
        };
        if (!0x2::dynamic_field::exists_<BitmapWordKey>(&arg0.id, v0)) {
            (false, 0)
        } else {
            (true, *0x2::dynamic_field::borrow<BitmapWordKey, u256>(&arg0.id, v0))
        }
    }

    public fun tail<T0: store>(arg0: &SkipList<T0>) : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::OptionU64 {
        arg0.tail
    }

    fun write_word<T0: store>(arg0: &mut SkipList<T0>, arg1: u8, arg2: u64, arg3: u256) {
        let v0 = BitmapWordKey{
            level      : arg1,
            word_index : arg2,
        };
        if (0x2::dynamic_field::exists_<BitmapWordKey>(&arg0.id, v0)) {
            if (arg3 == 0) {
                0x2::dynamic_field::remove<BitmapWordKey, u256>(&mut arg0.id, v0);
            } else {
                *0x2::dynamic_field::borrow_mut<BitmapWordKey, u256>(&mut arg0.id, v0) = arg3;
            };
        } else if (arg3 != 0) {
            0x2::dynamic_field::add<BitmapWordKey, u256>(&mut arg0.id, v0, arg3);
        };
    }

    // decompiled from Move bytecode v7
}

