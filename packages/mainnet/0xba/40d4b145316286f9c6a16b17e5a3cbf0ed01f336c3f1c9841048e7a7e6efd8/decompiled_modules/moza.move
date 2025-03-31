module 0xba40d4b145316286f9c6a16b17e5a3cbf0ed01f336c3f1c9841048e7a7e6efd8::moza {
    struct MOZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOZA>(arg0, 9, b"MOZA", b"mozaik", b"Get ready to welcome Moza, a brand new meme coin project that's about to make waves! Inspired by the concept of a grand ship embarking on an exciting voyage, Moza aims to capture the fun and viral potential of the meme coin world. Just like a ship exploring uncharted waters, Moza is setting out on a journey filled with community, engagement, and maybe a few unexpected treasures along the way. Hop aboard and join the Moza crew as we navigate the crypto seas together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/db99be74d27f9d5663081092d5ef29b3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOZA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOZA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

