module 0xbc4540afeb8ad01eb6efd4dc040f70a87fc5d8abafa7d68df32dc5c4e414db5f::chippy {
    struct CHIPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIPPY>(arg0, 6, b"CHIPPY", b"Chippy AI Dog", b"\"Chippy AI\" is a cutting-edge project that combines artificial intelligence with an approachable and cheerful personality. Designed to be your tech-savvy companion, Chippy AI excels in simplifying complex tasks, offering creative solutions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736005201347.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHIPPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIPPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

