module 0x7e7509d4181d2a948102936b9d5ec67ea22f7f16c14415a113855ac4e2c6f73f::dlm {
    struct DLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DLM>(arg0, 6, b"DLM", b"Dogelon Mars", b"I am Dogelon, Dogelon Mars. Join me and together we will reach the stars", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_11_29_15_cd562d114a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

