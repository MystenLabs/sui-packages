module 0x6c0ac8c0e86b8f43a1d8710af3829e05c7284d202752c24a9576c42a756934b0::kaku {
    struct KAKU has drop {
        dummy_field: bool,
    }

    struct OpsConfig has key {
        id: 0x2::object::UID,
        ops_wallet: address,
        prize_bps: u64,
    }

    struct KakuMinter has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<KAKU>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct KakuPurchased has copy, drop {
        buyer: address,
        sui_paid: u64,
        kaku_minted: u64,
        ops_wallet: address,
    }

    public fun buy_with_sui(arg0: &mut KakuMinter, arg1: &OpsConfig, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v1 = kaku_for_mist(v0);
        assert!(v1 > 0, 1);
        let v2 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg1.ops_wallet);
        0x2::transfer::public_transfer<0x2::coin::Coin<KAKU>>(0x2::coin::mint<KAKU>(&mut arg0.cap, v1, arg3), v2);
        let v3 = KakuPurchased{
            buyer       : v2,
            sui_paid    : v0,
            kaku_minted : v1,
            ops_wallet  : arg1.ops_wallet,
        };
        0x2::event::emit<KakuPurchased>(v3);
    }

    fun init(arg0: KAKU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KAKU>(arg0, 0, b"KAKU", b"Kaku", b"Kaku Skills loyalty token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kakuskills.grok.me/kaku.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAKU>>(v2);
        let v3 = KakuMinter{
            id  : 0x2::object::new(arg1),
            cap : v1,
        };
        0x2::transfer::share_object<KakuMinter>(v3);
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v4, v0);
        let v5 = OpsConfig{
            id         : 0x2::object::new(arg1),
            ops_wallet : v0,
            prize_bps  : 2500,
        };
        0x2::transfer::share_object<OpsConfig>(v5);
    }

    public fun kaku_for_mist(arg0: u64) : u64 {
        let v0 = arg0 / 1000000000;
        if (v0 == 10) {
            1300
        } else {
            v0 * 100
        }
    }

    public fun mint_to(arg0: &AdminCap, arg1: &mut KakuMinter, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KAKU>>(0x2::coin::mint<KAKU>(&mut arg1.cap, arg2, arg4), arg3);
    }

    public fun ops_wallet(arg0: &OpsConfig) : address {
        arg0.ops_wallet
    }

    public fun prize_bps(arg0: &OpsConfig) : u64 {
        arg0.prize_bps
    }

    public fun set_ops_wallet(arg0: &AdminCap, arg1: &mut OpsConfig, arg2: address) {
        arg1.ops_wallet = arg2;
    }

    public fun set_prize_bps(arg0: &AdminCap, arg1: &mut OpsConfig, arg2: u64) {
        assert!(arg2 <= 10000, 0);
        arg1.prize_bps = arg2;
    }

    // decompiled from Move bytecode v7
}

