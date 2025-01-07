module 0x53b243d6fd6f05e6e48a37a32242fa5d347360f4dcdb2567c2844bf02ea2f494::koss {
    struct KOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOSS>(arg0, 6, b"KOSS", b"Koss", b"KOSS will be a MOASS! To the MOON!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image2_3dff504662.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

