module 0xcf2d69158d84ab2474ef9644ce644e622169c9a67104b31fd85ecd353b377a7::sami {
    struct SAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMI>(arg0, 6, b"SAMI", b"Samito", b"Meme community on Sui for dog lovers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Coloe_95ae9458d4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

