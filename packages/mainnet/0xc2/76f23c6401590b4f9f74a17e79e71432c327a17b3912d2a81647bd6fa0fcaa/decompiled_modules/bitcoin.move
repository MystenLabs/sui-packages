module 0xc276f23c6401590b4f9f74a17e79e71432c327a17b3912d2a81647bd6fa0fcaa::bitcoin {
    struct BITCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITCOIN>(arg0, 6, b"BITCOIN", b"The Harry Potter Obama Sonic 10 Inu Sui", b"Before the year 2023, when time did not exist, the universe manifested a store of value. The identification of this value is best described as the Quest (sometimes the Quest of Hallows). Anyone can relive the manifestation by charging their core of Neptune with enough opal as they sleep....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_06_19_16_9e21b4dad6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

