module 0x8e08915671e2617f76f3b93945056b87e0a23086e9b065f64b522f2502aee46b::relics {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        minted: u64,
        mint_fee: u64,
        treasury: address,
    }

    struct Relic has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        note: 0x1::string::String,
        generation: u8,
        serial: u64,
    }

    struct MintRecord has key {
        id: 0x2::object::UID,
        minters: 0x2::table::Table<address, bool>,
    }

    struct RelicMinted has copy, drop {
        id: 0x2::object::ID,
        minter: address,
        serial: u64,
    }

    struct MergeRequest has store, key {
        id: 0x2::object::UID,
        from: address,
        offered: Relic,
    }

    struct MergeDeal has store, key {
        id: 0x2::object::UID,
        from: address,
        offered: Relic,
        payment: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    struct RelicMerged has copy, drop {
        id: 0x2::object::ID,
        from: address,
        to: address,
        serial: u64,
        generation: u8,
    }

    public fun accept_deal(arg0: &mut Config, arg1: MergeDeal, arg2: Relic, arg3: &mut 0x2::tx_context::TxContext) {
        let MergeDeal {
            id      : v0,
            from    : v1,
            offered : v2,
            payment : v3,
        } = arg1;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, 0x2::tx_context::sender(arg3));
        finish_fuse(arg0, v1, v2, arg2, arg3);
    }

    public fun accept_merge(arg0: &mut Config, arg1: MergeRequest, arg2: Relic, arg3: &mut 0x2::tx_context::TxContext) {
        let MergeRequest {
            id      : v0,
            from    : v1,
            offered : v2,
        } = arg1;
        0x2::object::delete(v0);
        finish_fuse(arg0, v1, v2, arg2, arg3);
    }

    public fun cancel_deal(arg0: MergeDeal, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.from, 4);
        reject_deal(arg0);
    }

    fun finish_fuse(arg0: &mut Config, arg1: address, arg2: Relic, arg3: Relic, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2.generation;
        let v1 = arg3.generation;
        let v2 = if (v0 > v1) {
            v0
        } else {
            v1
        };
        let v3 = v2 + 1;
        assert!(v3 <= 3, 3);
        let Relic {
            id          : v4,
            name        : v5,
            description : _,
            image_url   : _,
            note        : v8,
            generation  : _,
            serial      : _,
        } = arg2;
        let Relic {
            id          : v11,
            name        : v12,
            description : _,
            image_url   : _,
            note        : v15,
            generation  : _,
            serial      : _,
        } = arg3;
        0x2::object::delete(v4);
        0x2::object::delete(v11);
        arg0.minted = arg0.minted + 1;
        let v18 = arg0.minted;
        let v19 = v5;
        0x1::string::append_utf8(&mut v19, b" + ");
        0x1::string::append(&mut v19, v12);
        let v20 = v8;
        0x1::string::append_utf8(&mut v20, b" | ");
        0x1::string::append(&mut v20, v15);
        let v21 = Relic{
            id          : 0x2::object::new(arg4),
            name        : v19,
            description : 0x1::string::utf8(b"Fusion Relic"),
            image_url   : gen_art(v3),
            note        : v20,
            generation  : v3,
            serial      : v18,
        };
        let v22 = RelicMerged{
            id         : 0x2::object::id<Relic>(&v21),
            from       : arg1,
            to         : 0x2::tx_context::sender(arg4),
            serial     : v18,
            generation : v3,
        };
        0x2::event::emit<RelicMerged>(v22);
        0x2::transfer::public_transfer<Relic>(v21, arg1);
    }

    fun gen_art(arg0: u8) : 0x1::string::String {
        if (arg0 == 1) {
            0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-object-id/0xb497c56ada9b1db879144b02c4923c760e92a1a87e40deb4a62b3940872a5bff")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-object-id/0x44e1460c8b8a05927205903c441a62b4c68ee8ee8d2ff9289314eaf499a540b2")
        } else {
            0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-object-id/0x0a0772b54f02f4ada6e85a9d8534fb13c38727a23d2c2b1d9659f84e7b009beb")
        }
    }

    public fun has_minted(arg0: &MintRecord, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.minters, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Config{
            id       : 0x2::object::new(arg0),
            minted   : 0,
            mint_fee : 100000000000,
            treasury : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Config>(v1);
        let v2 = MintRecord{
            id      : 0x2::object::new(arg0),
            minters : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<MintRecord>(v2);
    }

    public fun max_genesis() : u64 {
        3333
    }

    public fun mint_genesis_with_token<T0>(arg0: &mut Config, arg1: &mut MintRecord, arg2: 0x2::coin::Coin<T0>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        take_token_fee<T0>(arg0, arg2, arg7);
        let v0 = mint_inner(arg0, arg1, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<Relic>(v0, 0x2::tx_context::sender(arg7));
    }

    fun mint_inner(arg0: &mut Config, arg1: &mut MintRecord, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : Relic {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(arg0.minted < 3333, 0);
        assert!(!0x2::table::contains<address, bool>(&arg1.minters, v0), 1);
        0x2::table::add<address, bool>(&mut arg1.minters, v0, true);
        arg0.minted = arg0.minted + 1;
        let v1 = arg0.minted;
        let v2 = if (0x1::string::length(&arg4) == 0) {
            gen_art(1)
        } else {
            arg4
        };
        let v3 = Relic{
            id          : 0x2::object::new(arg6),
            name        : arg2,
            description : arg3,
            image_url   : v2,
            note        : arg5,
            generation  : 1,
            serial      : v1,
        };
        let v4 = RelicMinted{
            id     : 0x2::object::id<Relic>(&v3),
            minter : v0,
            serial : v1,
        };
        0x2::event::emit<RelicMinted>(v4);
        v3
    }

    public fun minted(arg0: &Config) : u64 {
        arg0.minted
    }

    public fun reject_deal(arg0: MergeDeal) {
        let MergeDeal {
            id      : v0,
            from    : v1,
            offered : v2,
            payment : v3,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<Relic>(v2, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, v1);
    }

    public fun reject_merge(arg0: MergeRequest) {
        let MergeRequest {
            id      : v0,
            from    : v1,
            offered : v2,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<Relic>(v2, v1);
    }

    public fun request_deal(arg0: Relic, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MergeDeal{
            id      : 0x2::object::new(arg3),
            from    : 0x2::tx_context::sender(arg3),
            offered : arg0,
            payment : arg1,
        };
        0x2::transfer::public_transfer<MergeDeal>(v0, arg2);
    }

    public fun request_merge(arg0: Relic, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MergeRequest{
            id      : 0x2::object::new(arg2),
            from    : 0x2::tx_context::sender(arg2),
            offered : arg0,
        };
        0x2::transfer::public_transfer<MergeRequest>(v0, arg1);
    }

    public fun set_fee(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        arg1.mint_fee = arg2;
    }

    public fun set_media(arg0: &mut Relic, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        arg0.image_url = arg1;
        arg0.note = arg2;
    }

    public fun set_name(arg0: &mut Relic, arg1: 0x1::string::String) {
        arg0.name = arg1;
    }

    public fun set_treasury(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        arg1.treasury = arg2;
    }

    fun take_token_fee<T0>(arg0: &Config, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= arg0.mint_fee, 2);
        if (v0 > arg0.mint_fee) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v0 - arg0.mint_fee, arg2), 0x2::tx_context::sender(arg2));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, arg0.mint_fee / 2, arg2), @0x0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.treasury);
    }

    // decompiled from Move bytecode v7
}

