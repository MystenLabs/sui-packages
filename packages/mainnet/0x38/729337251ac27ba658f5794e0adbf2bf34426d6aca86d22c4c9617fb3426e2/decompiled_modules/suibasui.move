module 0x38729337251ac27ba658f5794e0adbf2bf34426d6aca86d22c4c9617fb3426e2::suibasui {
    struct SUIBASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBASUI>(arg0, 6, b"SUIBASUI", b"SUIBA", b"the secret ingredient has always been a blue dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_12_014558295_90507ea1b3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

