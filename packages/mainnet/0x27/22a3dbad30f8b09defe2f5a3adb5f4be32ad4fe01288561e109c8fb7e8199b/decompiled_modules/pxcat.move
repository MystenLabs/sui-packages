module 0x2722a3dbad30f8b09defe2f5a3adb5f4be32ad4fe01288561e109c8fb7e8199b::pxcat {
    struct PXCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PXCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PXCAT>(arg0, 6, b"PXCAT", b"Pixel Cat", b"Pixel Cats is a fun and vibrant meme coin inspired by the playful world of pixel art and our beloved feline friends. Designed to bring joy to the crypto community, Pixel Cats combines creativity and humor, making it an engaging way to participate in the evolving landscape of digital currencies. Join the purr-fect community and let the meme magic unfold!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_I_de_ecran_din_2024_10_27_la_22_31_15_68641772b3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PXCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PXCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

