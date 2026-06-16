module 0xe0c2ed9cff8395b7de922da350145c5e3e9b13a4a39656476b6e6165f9d7f9cd::susn {
    struct SUSN has drop {
        dummy_field: bool,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<SUSN>,
    }

    public fun mint(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SUSN> {
        0x2::coin::mint<SUSN>(&mut arg0.cap, arg1, arg2)
    }

    fun init(arg0: SUSN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 6;
        let (v1, v2) = 0x2::coin::create_currency<SUSN>(arg0, v0, b"sUSN", b"sUSN", b"Test sUSN", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<SUSN>(&mut v3, 0x1::u64::pow(10, v0), 0x2::tx_context::sender(arg1), arg1);
        let v4 = Treasury{
            id  : 0x2::object::new(arg1),
            cap : v3,
        };
        0x2::transfer::share_object<Treasury>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUSN>>(v2);
    }

    // decompiled from Move bytecode v7
}

