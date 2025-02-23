module 0xec67d8747bcc60019769c4f4bd94119ab3bf18ea1125a8122cfdbcc2084c443f::labu {
    struct LABU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LABU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LABU>(arg0, 6, b"LABU", b"LABUBUS", b"La bu bus on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/6cbe82ae-849d-43e4-bbc4-7e0ce3093523.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LABU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LABU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

