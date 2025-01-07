module 0xafa3d349938f90486b7225ddfe15d69c7e0cf0cf2d15433e76c6c5c6e81c7497::wwal {
    struct WWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWAL>(arg0, 6, b"WWAL", b"WOBBLE WALRUS", b"Big, blubbery, and always in style. Wobble Walrus is waddling its way to meme stardom.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_032753795_f1a6bd16d7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

