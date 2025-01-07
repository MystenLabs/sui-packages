module 0x788c660a3e70d11026365b804a4b8de239b82c04bc4d828c538ada8ad50af9ac::neiro6900 {
    struct NEIRO6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRO6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRO6900>(arg0, 6, b"NEIRO6900", b"NEIROsui6900", b"Neiro coin is like the little sister to Doge and the heir to her legacy. Adopted by the same woman that once owned Kabosu (the dog behind the Doge meme), Neiro carries forward the true spirit of memecoins and internet culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cc_Nxuy_CK_400x400_a48c92efa1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRO6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIRO6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

