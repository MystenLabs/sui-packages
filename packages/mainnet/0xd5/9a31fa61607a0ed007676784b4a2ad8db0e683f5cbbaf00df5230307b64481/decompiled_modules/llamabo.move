module 0xd59a31fa61607a0ed007676784b4a2ad8db0e683f5cbbaf00df5230307b64481::llamabo {
    struct LLAMABO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLAMABO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLAMABO>(arg0, 6, b"LLAMABO", b"Llamaghini", b"Introducing Lamaghini the one-of-a-kind llama with a taste for luxury! As our market cap rises, we have big plans for our favorite four-legged friend.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pp_twiter_46481841df_4892be36ae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLAMABO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LLAMABO>>(v1);
    }

    // decompiled from Move bytecode v6
}

