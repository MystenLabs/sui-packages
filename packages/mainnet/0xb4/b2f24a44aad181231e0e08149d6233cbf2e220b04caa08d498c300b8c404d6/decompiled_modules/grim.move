module 0xb4b2f24a44aad181231e0e08149d6233cbf2e220b04caa08d498c300b8c404d6::grim {
    struct GRIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRIM>(arg0, 6, b"GRIM", b"Grim On Sui", b"GRIM is more than a  meme___It's a movement", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000025592_01716dfbc4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

