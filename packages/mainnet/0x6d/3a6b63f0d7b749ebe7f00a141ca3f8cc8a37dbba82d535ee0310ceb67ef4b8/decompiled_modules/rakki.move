module 0x6d3a6b63f0d7b749ebe7f00a141ca3f8cc8a37dbba82d535ee0310ceb67ef4b8::rakki {
    struct RAKKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAKKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAKKI>(arg0, 6, b"Rakki", b"RaKkI CaT", b"A meme coin inspired by Japan's \"maneki-neko,\" symbolizing luck and prosperity. Built on the #Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_K1_lu_j_400x400_c924b6887d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAKKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAKKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

