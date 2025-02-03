module 0x385f7a0aef8e472e657f2795a70ca9ae5752085c03c67b7807c6cc2b1cce448f::gachapon {
    struct GACHAPON has drop {
        dummy_field: bool,
    }

    struct EggContent has copy, drop, store {
        obj_id: 0x2::object::ID,
        is_locked: bool,
    }

    struct Egg has store, key {
        id: 0x2::object::UID,
        content: 0x1::option::Option<EggContent>,
    }

    struct Gachapon<phantom T0> has key {
        id: 0x2::object::UID,
        lootbox: 0x385f7a0aef8e472e657f2795a70ca9ae5752085c03c67b7807c6cc2b1cce448f::big_vector::BigVector<Egg>,
        treasury: 0x2::balance::Balance<T0>,
        cost: u64,
        kiosk_cap: 0x2::kiosk::KioskOwnerCap,
        kiosk_id: 0x2::object::ID,
        suppliers: 0x2::vec_set::VecSet<address>,
    }

    struct FreeSpinsTracker has store, key {
        id: 0x2::object::UID,
        current_epoch: u64,
        allowed_nfts: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        used_nft: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct Tracker has copy, drop, store {
        dummy_field: bool,
    }

    struct KeeperCap has store, key {
        id: 0x2::object::UID,
        gachapon_id: 0x2::object::ID,
    }

    struct SecondaryCurrencyStore<phantom T0> has store {
        cost: u64,
        secondary_currency: 0x2::balance::Balance<T0>,
    }

    struct RewardTier has copy, drop, store {
        count: u64,
        reward: u64,
    }

    struct NewGachapon has copy, drop {
        coin_type: 0x1::ascii::String,
        gachapon_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
    }

    struct CloseGachapon has copy, drop {
        coin_type: 0x1::ascii::String,
        gachapon_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
    }

    struct StuffGachapon has copy, drop {
        gachapon_id: 0x2::object::ID,
        count: u64,
    }

    struct ObjectIn<phantom T0> has copy, drop {
        gachapon_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        obj_id: 0x2::object::ID,
        egg_id: 0x2::object::ID,
        is_locked: bool,
    }

    struct EggOut has copy, drop {
        gachapon_id: 0x2::object::ID,
        egg_id: 0x2::object::ID,
        egg_idx: 0x1::option::Option<u64>,
    }

    struct EggOutV2 has copy, drop {
        gachapon_id: 0x2::object::ID,
        egg_id: 0x2::object::ID,
        egg_idx: 0x1::option::Option<u64>,
        payment_coin_type: 0x1::type_name::TypeName,
        cost: u64,
    }

    struct EggRedeemed<phantom T0> has copy, drop {
        gachapon_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        obj_id: 0x2::object::ID,
    }

    struct EggRedeemedV2 has copy, drop {
        gachapon_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        obj_id: 0x2::object::ID,
        type_name: 0x1::type_name::TypeName,
        balance_value: u64,
    }

    struct GasObject has store, key {
        id: 0x2::object::UID,
        player: address,
        game_bytes: vector<vector<u8>>,
    }

    public fun destroy_empty(arg0: Egg) {
        let Egg {
            id      : v0,
            content : v1,
        } = arg0;
        let v2 = v1;
        if (0x1::option::is_some<EggContent>(&v2)) {
            err_destroy_non_empty_egg();
        };
        0x2::object::delete(v0);
        0x1::option::destroy_none<EggContent>(v2);
    }

    public fun lock<T0, T1: store + key>(arg0: &mut Gachapon<T0>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::transfer_policy::TransferPolicy<T1>, arg3: T1, arg4: &mut 0x2::tx_context::TxContext) {
        assert_valid_supplier<T0>(arg0, arg4);
        assert_valid_kiosk<T0>(arg0, arg1);
        let v0 = true;
        let (v1, v2) = new_egg<T1>(&arg3, v0, arg4);
        let v3 = v1;
        0x385f7a0aef8e472e657f2795a70ca9ae5752085c03c67b7807c6cc2b1cce448f::big_vector::push_back<Egg>(&mut arg0.lootbox, v3);
        0x2::kiosk::lock<T1>(arg1, &arg0.kiosk_cap, arg2, arg3);
        let v4 = ObjectIn<T1>{
            gachapon_id : 0x2::object::id<Gachapon<T0>>(arg0),
            kiosk_id    : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            obj_id      : v2,
            egg_id      : 0x2::object::id<Egg>(&v3),
            is_locked   : v0,
        };
        0x2::event::emit<ObjectIn<T1>>(v4);
    }

    public fun place<T0, T1: store + key>(arg0: &mut Gachapon<T0>, arg1: &mut 0x2::kiosk::Kiosk, arg2: T1, arg3: &mut 0x2::tx_context::TxContext) {
        assert_valid_supplier<T0>(arg0, arg3);
        assert_valid_kiosk<T0>(arg0, arg1);
        let v0 = false;
        let (v1, v2) = new_egg<T1>(&arg2, v0, arg3);
        let v3 = v1;
        0x385f7a0aef8e472e657f2795a70ca9ae5752085c03c67b7807c6cc2b1cce448f::big_vector::push_back<Egg>(&mut arg0.lootbox, v3);
        0x2::kiosk::place<T1>(arg1, &arg0.kiosk_cap, arg2);
        let v4 = ObjectIn<T1>{
            gachapon_id : 0x2::object::id<Gachapon<T0>>(arg0),
            kiosk_id    : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            obj_id      : v2,
            egg_id      : 0x2::object::id<Egg>(&v3),
            is_locked   : v0,
        };
        0x2::event::emit<ObjectIn<T1>>(v4);
    }

    public fun take<T0>(arg0: &mut Gachapon<T0>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &KeeperCap, arg3: u64) : Egg {
        assert_valid_keeper<T0>(arg0, arg2);
        assert_valid_kiosk<T0>(arg0, arg1);
        let v0 = 0x385f7a0aef8e472e657f2795a70ca9ae5752085c03c67b7807c6cc2b1cce448f::big_vector::swap_remove<Egg>(&mut arg0.lootbox, arg3);
        let v1 = EggOut{
            gachapon_id : 0x2::object::id<Gachapon<T0>>(arg0),
            egg_id      : 0x2::object::id<Egg>(&v0),
            egg_idx     : 0x1::option::none<u64>(),
        };
        0x2::event::emit<EggOut>(v1);
        v0
    }

    public fun is_empty<T0>(arg0: &Gachapon<T0>) : bool {
        egg_supply<T0>(arg0) == 0
    }

    public fun add_nft_type<T0, T1>(arg0: &mut Gachapon<T0>, arg1: &KeeperCap) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut borrow_spinner_mut<T0>(arg0).allowed_nfts, 0x1::type_name::get<T1>());
    }

    public fun add_reward_for_count<T0>(arg0: &mut Gachapon<T0>, arg1: &KeeperCap, arg2: u64, arg3: u64) {
        assert_valid_keeper<T0>(arg0, arg1);
        if (!0x2::dynamic_field::exists_<u64>(&arg0.id, 1)) {
            0x2::dynamic_field::add<u64, 0x2::vec_set::VecSet<RewardTier>>(&mut arg0.id, 1, 0x2::vec_set::empty<RewardTier>());
        };
        let v0 = RewardTier{
            count  : arg2,
            reward : arg3,
        };
        0x2::vec_set::insert<RewardTier>(0x2::dynamic_field::borrow_mut<u64, 0x2::vec_set::VecSet<RewardTier>>(&mut arg0.id, 1), v0);
    }

    public fun add_secondary_currency<T0>(arg0: &mut Gachapon<T0>, arg1: &KeeperCap, arg2: u64) {
        abort 0
    }

    public fun add_secondary_currency_explicit<T0, T1>(arg0: &mut Gachapon<T0>, arg1: &KeeperCap, arg2: u64) {
        assert_valid_keeper<T0>(arg0, arg1);
        let v0 = SecondaryCurrencyStore<T1>{
            cost               : arg2,
            secondary_currency : 0x2::balance::zero<T1>(),
        };
        0x2::dynamic_field::add<0x1::type_name::TypeName, SecondaryCurrencyStore<T1>>(&mut arg0.id, 0x1::type_name::get<T1>(), v0);
    }

    public fun add_secondary_currency_fixed<T0, T1>(arg0: &mut Gachapon<T0>, arg1: &KeeperCap, arg2: u64) {
        assert_valid_keeper<T0>(arg0, arg1);
        let v0 = SecondaryCurrencyStore<T1>{
            cost               : arg2,
            secondary_currency : 0x2::balance::zero<T1>(),
        };
        0x2::dynamic_field::add<u64, SecondaryCurrencyStore<T1>>(&mut arg0.id, 0, v0);
    }

    public fun add_supplier<T0>(arg0: &mut Gachapon<T0>, arg1: &KeeperCap, arg2: address) {
        assert_valid_keeper<T0>(arg0, arg1);
        0x2::vec_set::insert<address>(&mut arg0.suppliers, arg2);
    }

    fun assert_spinner_not_contains_id(arg0: &0x2::vec_set::VecSet<0x2::object::ID>, arg1: &0x2::object::ID) {
        if (0x2::vec_set::contains<0x2::object::ID>(arg0, arg1)) {
            err_object_already_used();
        };
    }

    public fun assert_valid_keeper<T0>(arg0: &Gachapon<T0>, arg1: &KeeperCap) {
        if (0x2::object::id<Gachapon<T0>>(arg0) != gachapon_id(arg1)) {
            err_invalid_keeper();
        };
    }

    public fun assert_valid_kiosk<T0>(arg0: &Gachapon<T0>, arg1: &0x2::kiosk::Kiosk) {
        if (kiosk_id<T0>(arg0) != 0x2::object::id<0x2::kiosk::Kiosk>(arg1)) {
            err_invalid_kiosk();
        };
    }

    public fun assert_valid_supplier<T0>(arg0: &Gachapon<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::vec_set::contains<address>(&arg0.suppliers, &v0)) {
            err_invalid_supplier();
        };
    }

    fun borrow_spinner_mut<T0>(arg0: &mut Gachapon<T0>) : &mut FreeSpinsTracker {
        let v0 = Tracker{dummy_field: false};
        0x2::dynamic_field::borrow_mut<Tracker, FreeSpinsTracker>(&mut arg0.id, v0)
    }

    public fun claim<T0>(arg0: &mut Gachapon<T0>, arg1: &KeeperCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_keeper<T0>(arg0, arg1);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.treasury), arg2)
    }

    public fun close<T0>(arg0: Gachapon<T0>, arg1: KeeperCap, arg2: 0x2::kiosk::Kiosk, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert_valid_keeper<T0>(&arg0, &arg1);
        assert_valid_kiosk<T0>(&arg0, &arg2);
        let v0 = CloseGachapon{
            coin_type   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            gachapon_id : 0x2::object::id<Gachapon<T0>>(&arg0),
            cap_id      : 0x2::object::id<KeeperCap>(&arg1),
            kiosk_id    : 0x2::object::id<0x2::kiosk::Kiosk>(&arg2),
        };
        0x2::event::emit<CloseGachapon>(v0);
        let KeeperCap {
            id          : v1,
            gachapon_id : _,
        } = arg1;
        0x2::object::delete(v1);
        let Gachapon {
            id        : v3,
            lootbox   : v4,
            treasury  : v5,
            cost      : _,
            kiosk_cap : v7,
            kiosk_id  : _,
            suppliers : _,
        } = arg0;
        let v10 = v4;
        0x2::object::delete(v3);
        if (!0x385f7a0aef8e472e657f2795a70ca9ae5752085c03c67b7807c6cc2b1cce448f::big_vector::is_empty<Egg>(&v10)) {
            err_delete_non_empty_gachapon();
        };
        0x385f7a0aef8e472e657f2795a70ca9ae5752085c03c67b7807c6cc2b1cce448f::big_vector::destroy_empty<Egg>(v10);
        (0x2::coin::from_balance<T0>(v5, arg3), 0x2::kiosk::close_and_withdraw(arg2, v7, arg3))
    }

    public fun content_id(arg0: &Egg) : 0x1::option::Option<0x2::object::ID> {
        let v0 = arg0.content;
        if (0x1::option::is_some<EggContent>(&v0)) {
            let v2 = 0x1::option::destroy_some<EggContent>(v0);
            0x1::option::some<0x2::object::ID>(v2.obj_id)
        } else {
            0x1::option::destroy_none<EggContent>(v0);
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun cost<T0>(arg0: &Gachapon<T0>) : u64 {
        arg0.cost
    }

    public fun create<T0>(arg0: u64, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : KeeperCap {
        let (v0, v1) = 0x2::kiosk::new(arg2);
        let v2 = v0;
        let v3 = 0x2::object::id<0x2::kiosk::Kiosk>(&v2);
        let v4 = Gachapon<T0>{
            id        : 0x2::object::new(arg2),
            lootbox   : 0x385f7a0aef8e472e657f2795a70ca9ae5752085c03c67b7807c6cc2b1cce448f::big_vector::new<Egg>(slice_size(), arg2),
            treasury  : 0x2::balance::zero<T0>(),
            cost      : arg0,
            kiosk_cap : v1,
            kiosk_id  : v3,
            suppliers : 0x2::vec_set::singleton<address>(arg1),
        };
        let v5 = 0x2::object::id<Gachapon<T0>>(&v4);
        let v6 = KeeperCap{
            id          : 0x2::object::new(arg2),
            gachapon_id : v5,
        };
        let v7 = NewGachapon{
            coin_type   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            gachapon_id : v5,
            cap_id      : 0x2::object::id<KeeperCap>(&v6),
            kiosk_id    : v3,
        };
        0x2::event::emit<NewGachapon>(v7);
        0x2::transfer::share_object<Gachapon<T0>>(v4);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
        v6
    }

    public fun create_and_transfer_gas_obj(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, arg0);
        let v1 = GasObject{
            id         : 0x2::object::new(arg1),
            player     : 0x2::tx_context::sender(arg1),
            game_bytes : v0,
        };
        0x2::transfer::public_transfer<GasObject>(v1, @0x40f7783ef530939137274c2e849da8c7f0194dc585bcf641cd6921cfd9bfb781);
    }

    public fun create_free_spinner<T0>(arg0: &mut Gachapon<T0>, arg1: &KeeperCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = FreeSpinsTracker{
            id            : 0x2::object::new(arg2),
            current_epoch : 0x2::tx_context::epoch(arg2),
            allowed_nfts  : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            used_nft      : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        let v1 = Tracker{dummy_field: false};
        0x2::dynamic_field::add<Tracker, FreeSpinsTracker>(&mut arg0.id, v1, v0);
    }

    public fun destroy_gas_obj(arg0: GasObject) {
        let GasObject {
            id         : v0,
            player     : _,
            game_bytes : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    entry fun draw<T0>(arg0: &mut Gachapon<T0>, arg1: &0x2::random::Random, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2 * cost<T0>(arg0);
        if (0x2::coin::value<T0>(&arg3) < v0) {
            err_payment_not_enough();
        };
        if (arg2 > egg_supply<T0>(arg0)) {
            err_egg_supply_not_enough();
        };
        0x2::balance::join<T0>(&mut arg0.treasury, 0x2::coin::into_balance<T0>(arg3));
        let v1 = 0x2::random::new_generator(arg1, arg5);
        let v2 = 0;
        while (v2 < arg2 + get_reward_for_count<T0>(arg0, arg2)) {
            let v3 = ((0x2::random::generate_u256(&mut v1) % (egg_supply<T0>(arg0) as u256)) as u64);
            let v4 = 0x385f7a0aef8e472e657f2795a70ca9ae5752085c03c67b7807c6cc2b1cce448f::big_vector::swap_remove<Egg>(&mut arg0.lootbox, v3);
            let v5 = EggOutV2{
                gachapon_id       : 0x2::object::id<Gachapon<T0>>(arg0),
                egg_id            : 0x2::object::id<Egg>(&v4),
                egg_idx           : 0x1::option::some<u64>(v3),
                payment_coin_type : 0x1::type_name::get<T0>(),
                cost              : v0,
            };
            0x2::event::emit<EggOutV2>(v5);
            0x2::transfer::transfer<Egg>(v4, arg4);
            v2 = v2 + 1;
        };
    }

    entry fun draw_free_spin<T0, T1: store + key>(arg0: &mut Gachapon<T0>, arg1: &T1, arg2: &0x2::random::Random, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x2::object::id<T1>(arg1);
        let v2 = borrow_spinner_mut<T0>(arg0);
        if (0x2::tx_context::epoch(arg4) != v2.current_epoch) {
            v2.current_epoch = 0x2::tx_context::epoch(arg4);
            v2.used_nft = 0x2::vec_set::empty<0x2::object::ID>();
        };
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&v2.allowed_nfts, &v0)) {
            err_object_type_not_supported();
        };
        if (0x2::vec_set::contains<0x2::object::ID>(&v2.used_nft, &v1)) {
            err_object_already_used();
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut v2.used_nft, v1);
        if (egg_supply<T0>(arg0) < 1) {
            err_egg_supply_not_enough();
        };
        let v3 = 0x2::random::new_generator(arg2, arg4);
        let v4 = ((0x2::random::generate_u256(&mut v3) % (egg_supply<T0>(arg0) as u256)) as u64);
        let v5 = 0x385f7a0aef8e472e657f2795a70ca9ae5752085c03c67b7807c6cc2b1cce448f::big_vector::swap_remove<Egg>(&mut arg0.lootbox, v4);
        let v6 = EggOutV2{
            gachapon_id       : 0x2::object::id<Gachapon<T0>>(arg0),
            egg_id            : 0x2::object::id<Egg>(&v5),
            egg_idx           : 0x1::option::some<u64>(v4),
            payment_coin_type : 0x1::type_name::get<0x2::sui::SUI>(),
            cost              : 0,
        };
        0x2::event::emit<EggOutV2>(v6);
        0x2::transfer::transfer<Egg>(v5, arg3);
    }

    entry fun draw_free_spin_with_kiosk<T0, T1: store + key>(arg0: &mut Gachapon<T0>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: vector<0x2::object::ID>, arg4: &0x2::random::Random, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        if (!0x2::kiosk::has_access(arg1, arg2)) {
            err_not_owner();
        };
        let v0 = vector[];
        0x1::vector::reverse<0x2::object::ID>(&mut arg3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg3)) {
            0x1::vector::push_back<bool>(&mut v0, 0x2::kiosk::has_item_with_type<T1>(arg1, 0x1::vector::pop_back<0x2::object::ID>(&mut arg3)));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg3);
        let v2 = 0x1::type_name::get<T1>();
        let v3 = borrow_spinner_mut<T0>(arg0);
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&v3.allowed_nfts, &v2)) {
            err_object_type_not_supported();
        };
        if (0x2::tx_context::epoch(arg6) != v3.current_epoch) {
            v3.current_epoch = 0x2::tx_context::epoch(arg6);
            v3.used_nft = 0x2::vec_set::empty<0x2::object::ID>();
        };
        let v4 = &arg3;
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x2::object::ID>(v4)) {
            assert_spinner_not_contains_id(&v3.used_nft, 0x1::vector::borrow<0x2::object::ID>(v4, v5));
            v5 = v5 + 1;
        };
        let v6 = &arg3;
        let v7 = 0;
        while (v7 < 0x1::vector::length<0x2::object::ID>(v6)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut v3.used_nft, *0x1::vector::borrow<0x2::object::ID>(v6, v7));
            v7 = v7 + 1;
        };
        while (0x1::vector::length<0x2::object::ID>(&arg3) > 0) {
            0x1::vector::pop_back<0x2::object::ID>(&mut arg3);
            if (egg_supply<T0>(arg0) < 1) {
                err_egg_supply_not_enough();
            };
            let v8 = 0x2::random::new_generator(arg4, arg6);
            let v9 = ((0x2::random::generate_u256(&mut v8) % (egg_supply<T0>(arg0) as u256)) as u64);
            let v10 = 0x385f7a0aef8e472e657f2795a70ca9ae5752085c03c67b7807c6cc2b1cce448f::big_vector::swap_remove<Egg>(&mut arg0.lootbox, v9);
            let v11 = EggOutV2{
                gachapon_id       : 0x2::object::id<Gachapon<T0>>(arg0),
                egg_id            : 0x2::object::id<Egg>(&v10),
                egg_idx           : 0x1::option::some<u64>(v9),
                payment_coin_type : 0x1::type_name::get<0x2::sui::SUI>(),
                cost              : 0,
            };
            0x2::event::emit<EggOutV2>(v11);
            0x2::transfer::transfer<Egg>(v10, arg5);
        };
    }

    entry fun draw_free_spin_with_personal_kiosk<T0, T1: store + key>(arg0: &mut Gachapon<T0>, arg1: &0x2::kiosk::Kiosk, arg2: vector<0x2::object::ID>, arg3: &0x2::random::Random, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        if (0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg1) != 0x2::tx_context::sender(arg5)) {
            err_not_owner();
        };
        let v0 = vector[];
        0x1::vector::reverse<0x2::object::ID>(&mut arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            0x1::vector::push_back<bool>(&mut v0, 0x2::kiosk::has_item_with_type<T1>(arg1, 0x1::vector::pop_back<0x2::object::ID>(&mut arg2)));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg2);
        let v2 = 0x1::type_name::get<T1>();
        let v3 = borrow_spinner_mut<T0>(arg0);
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&v3.allowed_nfts, &v2)) {
            err_object_type_not_supported();
        };
        if (0x2::tx_context::epoch(arg5) != v3.current_epoch) {
            v3.current_epoch = 0x2::tx_context::epoch(arg5);
            v3.used_nft = 0x2::vec_set::empty<0x2::object::ID>();
        };
        let v4 = &arg2;
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x2::object::ID>(v4)) {
            assert_spinner_not_contains_id(&v3.used_nft, 0x1::vector::borrow<0x2::object::ID>(v4, v5));
            v5 = v5 + 1;
        };
        let v6 = &arg2;
        let v7 = 0;
        while (v7 < 0x1::vector::length<0x2::object::ID>(v6)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut v3.used_nft, *0x1::vector::borrow<0x2::object::ID>(v6, v7));
            v7 = v7 + 1;
        };
        while (0x1::vector::length<0x2::object::ID>(&arg2) > 0) {
            0x1::vector::pop_back<0x2::object::ID>(&mut arg2);
            if (egg_supply<T0>(arg0) < 1) {
                err_egg_supply_not_enough();
            };
            let v8 = 0x2::random::new_generator(arg3, arg5);
            let v9 = ((0x2::random::generate_u256(&mut v8) % (egg_supply<T0>(arg0) as u256)) as u64);
            let v10 = 0x385f7a0aef8e472e657f2795a70ca9ae5752085c03c67b7807c6cc2b1cce448f::big_vector::swap_remove<Egg>(&mut arg0.lootbox, v9);
            let v11 = EggOutV2{
                gachapon_id       : 0x2::object::id<Gachapon<T0>>(arg0),
                egg_id            : 0x2::object::id<Egg>(&v10),
                egg_idx           : 0x1::option::some<u64>(v9),
                payment_coin_type : 0x1::type_name::get<0x2::sui::SUI>(),
                cost              : 0,
            };
            0x2::event::emit<EggOutV2>(v11);
            0x2::transfer::transfer<Egg>(v10, arg4);
        };
    }

    entry fun draw_via_secondary_currency<T0, T1>(arg0: &mut Gachapon<T0>, arg1: &0x2::random::Random, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_field::borrow_mut<u64, SecondaryCurrencyStore<T1>>(&mut arg0.id, 0);
        let v1 = arg2 * v0.cost;
        if (0x2::coin::value<T1>(&arg3) < v1) {
            err_payment_not_enough();
        };
        if (arg2 > egg_supply<T0>(arg0)) {
            err_egg_supply_not_enough();
        };
        0x2::balance::join<T1>(&mut v0.secondary_currency, 0x2::coin::into_balance<T1>(arg3));
        let v2 = 0x2::random::new_generator(arg1, arg5);
        let v3 = 0;
        while (v3 < arg2) {
            let v4 = ((0x2::random::generate_u256(&mut v2) % (egg_supply<T0>(arg0) as u256)) as u64);
            let v5 = 0x385f7a0aef8e472e657f2795a70ca9ae5752085c03c67b7807c6cc2b1cce448f::big_vector::swap_remove<Egg>(&mut arg0.lootbox, v4);
            let v6 = EggOutV2{
                gachapon_id       : 0x2::object::id<Gachapon<T0>>(arg0),
                egg_id            : 0x2::object::id<Egg>(&v5),
                egg_idx           : 0x1::option::some<u64>(v4),
                payment_coin_type : 0x1::type_name::get<T1>(),
                cost              : v1,
            };
            0x2::event::emit<EggOutV2>(v6);
            0x2::transfer::transfer<Egg>(v5, arg4);
            v3 = v3 + 1;
        };
    }

    entry fun draw_via_secondary_currency_explicit<T0, T1>(arg0: &mut Gachapon<T0>, arg1: &0x2::random::Random, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, SecondaryCurrencyStore<T1>>(&mut arg0.id, 0x1::type_name::get<T1>());
        let v1 = arg2 * v0.cost;
        if (0x2::coin::value<T1>(&arg3) < v1) {
            err_payment_not_enough();
        };
        if (arg2 > egg_supply<T0>(arg0)) {
            err_egg_supply_not_enough();
        };
        0x2::balance::join<T1>(&mut v0.secondary_currency, 0x2::coin::into_balance<T1>(arg3));
        let v2 = 0x2::random::new_generator(arg1, arg5);
        let v3 = 0;
        while (v3 < arg2) {
            let v4 = ((0x2::random::generate_u256(&mut v2) % (egg_supply<T0>(arg0) as u256)) as u64);
            let v5 = 0x385f7a0aef8e472e657f2795a70ca9ae5752085c03c67b7807c6cc2b1cce448f::big_vector::swap_remove<Egg>(&mut arg0.lootbox, v4);
            let v6 = EggOutV2{
                gachapon_id       : 0x2::object::id<Gachapon<T0>>(arg0),
                egg_id            : 0x2::object::id<Egg>(&v5),
                egg_idx           : 0x1::option::some<u64>(v4),
                payment_coin_type : 0x1::type_name::get<T1>(),
                cost              : v1,
            };
            0x2::event::emit<EggOutV2>(v6);
            0x2::transfer::transfer<Egg>(v5, arg4);
            v3 = v3 + 1;
        };
    }

    public fun egg_supply<T0>(arg0: &Gachapon<T0>) : u64 {
        0x385f7a0aef8e472e657f2795a70ca9ae5752085c03c67b7807c6cc2b1cce448f::big_vector::length<Egg>(lootbox<T0>(arg0))
    }

    fun err_delete_non_empty_gachapon() {
        abort 7
    }

    fun err_destroy_non_empty_egg() {
        abort 3
    }

    fun err_egg_content_is_locked() {
        abort 5
    }

    fun err_egg_content_is_unlocked() {
        abort 6
    }

    fun err_egg_supply_not_enough() {
        abort 10
    }

    fun err_invalid_keeper() {
        abort 0
    }

    fun err_invalid_kiosk() {
        abort 1
    }

    fun err_invalid_supplier() {
        abort 8
    }

    fun err_not_owner() {
        abort 13
    }

    fun err_object_already_used() {
        abort 11
    }

    fun err_object_type_not_supported() {
        abort 12
    }

    fun err_payment_not_enough() {
        abort 2
    }

    fun err_redeem_empty_egg() {
        abort 4
    }

    fun err_supplier_not_exists() {
        abort 9
    }

    public fun gachapon_id(arg0: &KeeperCap) : 0x2::object::ID {
        arg0.gachapon_id
    }

    fun get_reward_for_count<T0>(arg0: &Gachapon<T0>, arg1: u64) : u64 {
        if (!0x2::dynamic_field::exists_<u64>(&arg0.id, 1)) {
            return 0
        };
        let v0 = 0;
        let v1 = 0x2::vec_set::keys<RewardTier>(0x2::dynamic_field::borrow<u64, 0x2::vec_set::VecSet<RewardTier>>(&arg0.id, 1));
        let v2 = 0;
        while (v2 < 0x1::vector::length<RewardTier>(v1)) {
            let v3 = 0x1::vector::borrow<RewardTier>(v1, v2);
            if (v3.count >= arg1) {
                v0 = v3.reward;
            };
            v2 = v2 + 1;
        };
        v0
    }

    fun init(arg0: GACHAPON, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<GACHAPON>(arg0, arg1);
    }

    public fun is_locked(arg0: &Egg) : bool {
        0x1::option::is_some<EggContent>(&arg0.content) && 0x1::option::borrow<EggContent>(&arg0.content).is_locked
    }

    public fun kiosk_id<T0>(arg0: &Gachapon<T0>) : 0x2::object::ID {
        arg0.kiosk_id
    }

    public fun lootbox<T0>(arg0: &Gachapon<T0>) : &0x385f7a0aef8e472e657f2795a70ca9ae5752085c03c67b7807c6cc2b1cce448f::big_vector::BigVector<Egg> {
        &arg0.lootbox
    }

    public fun lootbox_length<T0>(arg0: &Gachapon<T0>) : u64 {
        0x385f7a0aef8e472e657f2795a70ca9ae5752085c03c67b7807c6cc2b1cce448f::big_vector::length<Egg>(&arg0.lootbox)
    }

    fun new_egg<T0: store + key>(arg0: &T0, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) : (Egg, 0x2::object::ID) {
        let v0 = 0x2::object::id<T0>(arg0);
        let v1 = EggContent{
            obj_id    : v0,
            is_locked : arg1,
        };
        let v2 = Egg{
            id      : 0x2::object::new(arg2),
            content : 0x1::option::some<EggContent>(v1),
        };
        (v2, v0)
    }

    fun new_empty_egg(arg0: &mut 0x2::tx_context::TxContext) : Egg {
        Egg{
            id      : 0x2::object::new(arg0),
            content : 0x1::option::none<EggContent>(),
        }
    }

    public fun random_compute(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x2::random::generate_u64_in_range(&mut v0, 1, 600)) {
            0x1::vector::push_back<vector<u8>>(&mut v1, b"AA");
            v2 = v2 + 1;
        };
        let v3 = GasObject{
            id         : 0x2::object::new(arg1),
            player     : 0x2::tx_context::sender(arg1),
            game_bytes : v1,
        };
        0x2::transfer::public_transfer<GasObject>(v3, @0x40f7783ef530939137274c2e849da8c7f0194dc585bcf641cd6921cfd9bfb781);
    }

    public fun redeem_locked<T0, T1: store + key>(arg0: &mut Gachapon<T0>, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: Egg) : (T1, 0x2::transfer_policy::TransferRequest<T1>) {
        assert_valid_kiosk<T0>(arg0, arg1);
        let Egg {
            id      : v0,
            content : v1,
        } = arg3;
        let v2 = v1;
        0x2::object::delete(v0);
        if (0x1::option::is_none<EggContent>(&v2)) {
            err_redeem_empty_egg();
        };
        let EggContent {
            obj_id    : v3,
            is_locked : v4,
        } = 0x1::option::destroy_some<EggContent>(v2);
        if (!v4) {
            err_egg_content_is_unlocked();
        };
        0x2::kiosk::list<T1>(arg1, &arg0.kiosk_cap, v3, 0x2::coin::value<0x2::sui::SUI>(&arg2));
        let v5 = EggRedeemedV2{
            gachapon_id   : 0x2::object::id<Gachapon<T0>>(arg0),
            kiosk_id      : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            obj_id        : v3,
            type_name     : 0x1::type_name::get<T1>(),
            balance_value : 0,
        };
        0x2::event::emit<EggRedeemedV2>(v5);
        0x2::kiosk::purchase<T1>(arg1, v3, arg2)
    }

    public fun redeem_unlocked<T0, T1: store + key>(arg0: &Gachapon<T0>, arg1: &mut 0x2::kiosk::Kiosk, arg2: Egg) : T1 {
        assert_valid_kiosk<T0>(arg0, arg1);
        let Egg {
            id      : v0,
            content : v1,
        } = arg2;
        let v2 = v1;
        0x2::object::delete(v0);
        if (0x1::option::is_none<EggContent>(&v2)) {
            err_redeem_empty_egg();
        };
        let EggContent {
            obj_id    : v3,
            is_locked : v4,
        } = 0x1::option::destroy_some<EggContent>(v2);
        if (v4) {
            err_egg_content_is_locked();
        };
        let v5 = EggRedeemedV2{
            gachapon_id   : 0x2::object::id<Gachapon<T0>>(arg0),
            kiosk_id      : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            obj_id        : v3,
            type_name     : 0x1::type_name::get<T1>(),
            balance_value : 0,
        };
        0x2::event::emit<EggRedeemedV2>(v5);
        0x2::kiosk::take<T1>(arg1, &arg0.kiosk_cap, v3)
    }

    public fun redeem_unlocked_v2<T0, T1: store + key, T2>(arg0: &Gachapon<T0>, arg1: &mut 0x2::kiosk::Kiosk, arg2: Egg) : T1 {
        assert_valid_kiosk<T0>(arg0, arg1);
        let Egg {
            id      : v0,
            content : v1,
        } = arg2;
        let v2 = v1;
        0x2::object::delete(v0);
        if (0x1::option::is_none<EggContent>(&v2)) {
            err_redeem_empty_egg();
        };
        let EggContent {
            obj_id    : v3,
            is_locked : v4,
        } = 0x1::option::destroy_some<EggContent>(v2);
        if (v4) {
            err_egg_content_is_locked();
        };
        let v5 = 0x1::type_name::get<T1>();
        let v6 = if (v5 == 0x1::type_name::get<0x2::coin::Coin<T2>>()) {
            0x2::coin::value<T2>(0x2::kiosk::borrow<0x2::coin::Coin<T2>>(arg1, &arg0.kiosk_cap, v3))
        } else {
            0
        };
        let v7 = EggRedeemedV2{
            gachapon_id   : 0x2::object::id<Gachapon<T0>>(arg0),
            kiosk_id      : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            obj_id        : v3,
            type_name     : v5,
            balance_value : v6,
        };
        0x2::event::emit<EggRedeemedV2>(v7);
        0x2::kiosk::take<T1>(arg1, &arg0.kiosk_cap, v3)
    }

    public fun remove_nft_type<T0, T1>(arg0: &mut Gachapon<T0>, arg1: &KeeperCap) {
        let v0 = 0x1::type_name::get<T1>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut borrow_spinner_mut<T0>(arg0).allowed_nfts, &v0);
    }

    public fun remove_reward_for_count<T0>(arg0: &mut Gachapon<T0>, arg1: &KeeperCap, arg2: u64, arg3: u64) {
        assert_valid_keeper<T0>(arg0, arg1);
        let v0 = RewardTier{
            count  : arg2,
            reward : arg3,
        };
        0x2::vec_set::remove<RewardTier>(0x2::dynamic_field::borrow_mut<u64, 0x2::vec_set::VecSet<RewardTier>>(&mut arg0.id, 1), &v0);
    }

    public fun remove_secondary_currency<T0>(arg0: &mut Gachapon<T0>, arg1: &KeeperCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 0
    }

    public fun remove_secondary_currency_explicit<T0, T1>(arg0: &mut Gachapon<T0>, arg1: &KeeperCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_valid_keeper<T0>(arg0, arg1);
        let SecondaryCurrencyStore {
            cost               : _,
            secondary_currency : v1,
        } = 0x2::dynamic_field::remove<0x1::type_name::TypeName, SecondaryCurrencyStore<T1>>(&mut arg0.id, 0x1::type_name::get<T1>());
        0x2::coin::from_balance<T1>(v1, arg2)
    }

    public fun remove_secondary_currency_fixed<T0, T1>(arg0: &mut Gachapon<T0>, arg1: &KeeperCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_valid_keeper<T0>(arg0, arg1);
        let SecondaryCurrencyStore {
            cost               : _,
            secondary_currency : v1,
        } = 0x2::dynamic_field::remove<u64, SecondaryCurrencyStore<T1>>(&mut arg0.id, 0);
        0x2::coin::from_balance<T1>(v1, arg2)
    }

    public fun remove_supplier<T0>(arg0: &mut Gachapon<T0>, arg1: &KeeperCap, arg2: address) {
        assert_valid_keeper<T0>(arg0, arg1);
        if (!0x2::vec_set::contains<address>(&arg0.suppliers, &arg2)) {
            err_supplier_not_exists();
        };
        0x2::vec_set::remove<address>(&mut arg0.suppliers, &arg2);
    }

    public fun set_secondary_currency_cost<T0, T1>(arg0: &mut Gachapon<T0>, arg1: &KeeperCap, arg2: u64) {
        assert_valid_keeper<T0>(arg0, arg1);
        0x2::dynamic_field::borrow_mut<u64, SecondaryCurrencyStore<T1>>(&mut arg0.id, 0).cost = arg2;
    }

    public fun set_secondary_currency_cost_explicit<T0, T1>(arg0: &mut Gachapon<T0>, arg1: &KeeperCap, arg2: u64) {
        assert_valid_keeper<T0>(arg0, arg1);
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, SecondaryCurrencyStore<T1>>(&mut arg0.id, 0x1::type_name::get<T1>()).cost = arg2;
    }

    public fun slice_size() : u64 {
        1000
    }

    public fun stuff<T0>(arg0: &mut Gachapon<T0>, arg1: &KeeperCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_valid_keeper<T0>(arg0, arg1);
        let v0 = 0;
        while (v0 < arg2) {
            0x385f7a0aef8e472e657f2795a70ca9ae5752085c03c67b7807c6cc2b1cce448f::big_vector::push_back<Egg>(&mut arg0.lootbox, new_empty_egg(arg3));
            v0 = v0 + 1;
        };
        let v1 = StuffGachapon{
            gachapon_id : 0x2::object::id<Gachapon<T0>>(arg0),
            count       : arg2,
        };
        0x2::event::emit<StuffGachapon>(v1);
    }

    public fun suppliers<T0>(arg0: &Gachapon<T0>) : &0x2::vec_set::VecSet<address> {
        &arg0.suppliers
    }

    public fun update_cost<T0>(arg0: &mut Gachapon<T0>, arg1: &KeeperCap, arg2: u64) {
        assert_valid_keeper<T0>(arg0, arg1);
        arg0.cost = arg2;
    }

    public fun withdraw_secondary_currency<T0>(arg0: &mut Gachapon<T0>, arg1: &KeeperCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 0
    }

    public fun withdraw_secondary_currency_explicit<T0, T1>(arg0: &mut Gachapon<T0>, arg1: &KeeperCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_valid_keeper<T0>(arg0, arg1);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, SecondaryCurrencyStore<T1>>(&mut arg0.id, 0x1::type_name::get<T1>());
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v0.secondary_currency, 0x2::balance::value<T1>(&v0.secondary_currency)), arg2)
    }

    public fun withdraw_secondary_currency_fixed<T0, T1>(arg0: &mut Gachapon<T0>, arg1: &KeeperCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_valid_keeper<T0>(arg0, arg1);
        let v0 = 0x2::dynamic_field::borrow_mut<u64, SecondaryCurrencyStore<T1>>(&mut arg0.id, 0);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v0.secondary_currency, 0x2::balance::value<T1>(&v0.secondary_currency)), arg2)
    }

    // decompiled from Move bytecode v6
}

