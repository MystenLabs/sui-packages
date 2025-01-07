module 0x975cebe8059f489d9d7d5210ebb79ae240d7a4af17d517aa7a0d1a802a66c012::memeism {
    struct MEMEISM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEISM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEISM>(arg0, 6, b"Memeism", b"Meme Religion", b"Memeism is a religion founded on December 15th-16th, 2017 in Spain, Madrid. The religion praises and swears loyalty to the gods of Ooof, Kek, Yee, Pepe the Frog, and Gabe the dog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MEMEISM_33b5dfdad5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEISM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMEISM>>(v1);
    }

    // decompiled from Move bytecode v6
}

