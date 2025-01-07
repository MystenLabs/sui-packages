module 0xd821058e4dae316c733ca1d577a6c5e3790d83aa8318fc3f68c91a2f73240ca5::puyi {
    struct PUYI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUYI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUYI>(arg0, 6, b"PUYI", b"Suipuyi", b"PUYI is a tiny, curious creature who loves to hop around and explore new places. Always up for an adventure, PUYI enjoys hanging out in the wild, leaping from one fun spot to another.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001086_ebe7eb5fb9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUYI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUYI>>(v1);
    }

    // decompiled from Move bytecode v6
}

