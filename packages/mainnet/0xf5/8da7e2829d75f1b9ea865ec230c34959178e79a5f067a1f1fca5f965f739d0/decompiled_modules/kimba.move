module 0xf58da7e2829d75f1b9ea865ec230c34959178e79a5f067a1f1fca5f965f739d0::kimba {
    struct KIMBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIMBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIMBA>(arg0, 6, b"KIMBA", b"Kimba on Sui", b"$Kimba is a meme token featuring a charismatic bird sui. With strength, courage, and an adventurous spirit, Kimba symbolizes leadersh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055278_aea67f8c20.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIMBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIMBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

