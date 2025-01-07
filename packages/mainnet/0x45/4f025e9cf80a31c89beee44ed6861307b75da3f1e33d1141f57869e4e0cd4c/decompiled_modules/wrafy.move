module 0x454f025e9cf80a31c89beee44ed6861307b75da3f1e33d1141f57869e4e0cd4c::wrafy {
    struct WRAFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WRAFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WRAFY>(arg0, 6, b"WRAFY", b"Wrafy Cat", b"Wrafy - The three legged meme Cat! - Real Story", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017861_a042b7c08f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRAFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WRAFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

