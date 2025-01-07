module 0x719d6e2e13a4a659f474e50a1a3d710d5b9e34518af302a762c43966fe48f2fb::sash {
    struct SASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASH>(arg0, 6, b"SASH", b"Sashimi", b"Only the very best food on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/magicstudio_art_2_2_606b4a9832.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

