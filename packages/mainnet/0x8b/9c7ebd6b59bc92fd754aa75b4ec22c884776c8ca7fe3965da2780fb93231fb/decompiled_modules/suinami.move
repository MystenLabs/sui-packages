module 0x8b9c7ebd6b59bc92fd754aa75b4ec22c884776c8ca7fe3965da2780fb93231fb::suinami {
    struct SUINAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINAMI>(arg0, 9, b"SUINAMI", x"f09f8c8a5375696e616d69", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUINAMI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINAMI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

