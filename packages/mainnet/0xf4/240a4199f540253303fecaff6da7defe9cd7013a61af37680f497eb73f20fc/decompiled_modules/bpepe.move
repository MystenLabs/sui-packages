module 0xf4240a4199f540253303fecaff6da7defe9cd7013a61af37680f497eb73f20fc::bpepe {
    struct BPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPEPE>(arg0, 6, b"BPepe", b"BabyPepe", b"BabyPepe is a fun and lighthearted meme project on the Sui blockchain, featuring an adorable frog character with a baby twist. Combining humor with blockchain innovation, BabyPepe is designed to bring joy to the crypto community through playful memes, vibrant design, and a strong connection to internet culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000352_3918c6bb7e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

