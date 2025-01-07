module 0x7ea318001c07810201dd7f2e26f40100f6b4e63003308e9095ee4119a0cc5b6d::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CAT>(arg0, 6, b"CAT", b"CatAI", b"The FIRST AI Cat on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000057641_629220acfe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CAT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

