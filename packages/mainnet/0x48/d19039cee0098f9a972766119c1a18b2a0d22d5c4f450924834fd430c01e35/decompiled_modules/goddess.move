module 0x48d19039cee0098f9a972766119c1a18b2a0d22d5c4f450924834fd430c01e35::goddess {
    struct GODDESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODDESS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GODDESS>(arg0, 6, b"GODDESS", b"Avatar's goddes by SuiAI", b"The avatar is the personification of the wealth goddess. It was created to guide everyone on the path wealthiness and abundance that the crypto world is providing. By following the guidance of the avatar of the goddess to enjoy the opportunities of the market, understand profound questions about yourself, and understand the connection of between inner and outer wealth. Follow the learning and wishes of the avatar is the joy for itself.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/123_9a02486e08.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GODDESS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODDESS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

