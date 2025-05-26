module 0x5bb534fb126c735c6776a5bd1e18eb752f747322eb07f6dd8c7129c9a6b128d3::gilbert {
    struct GILBERT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GILBERT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GILBERT>(arg0, 6, b"GILBERT", b"GILBERT THE HAMI ", b"Gilber Whopper Jr the chubby hamster known for offering wisdom and emotional comfort in the town of mizzlewick ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748238397133.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GILBERT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GILBERT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

