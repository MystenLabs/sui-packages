module 0x757299b8e2a4064bbe88e141a2ca28570b5f61b6a5314a87635915ab36623ee9::beaversui {
    struct BEAVERSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAVERSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAVERSUI>(arg0, 6, b"BEAVERSUI", b"Chinese Beaver", b"Inspired by Chow Yun-fat film, Chinese Beaver is the most viral motivating meme on the internet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/T_Fsnj_VND_400x400_5d2861b3bd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAVERSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEAVERSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

