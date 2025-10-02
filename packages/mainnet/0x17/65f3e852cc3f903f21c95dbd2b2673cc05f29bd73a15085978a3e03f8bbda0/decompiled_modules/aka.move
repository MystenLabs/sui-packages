module 0x1765f3e852cc3f903f21c95dbd2b2673cc05f29bd73a15085978a3e03f8bbda0::aka {
    struct AKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKA>(arg0, 6, b"AKA", b"FK Tanjiro Ver 2", b"AKAZA number one but dont buy token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1759391762313.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

