module 0xf8eaadf90609422e91a4c2d279e7cad6f8bd675bdad56ed0d92384c6c0c80525::soad {
    struct SOAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOAD>(arg0, 6, b"SOAD", b"ChopSui", b"You wanted to.. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000019834_fba2084e5f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

