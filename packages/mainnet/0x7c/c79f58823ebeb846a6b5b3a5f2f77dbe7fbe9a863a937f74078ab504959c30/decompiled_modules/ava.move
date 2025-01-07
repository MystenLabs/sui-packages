module 0x7cc79f58823ebeb846a6b5b3a5f2f77dbe7fbe9a863a937f74078ab504959c30::ava {
    struct AVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVA>(arg0, 6, b"Ava", b"AVA", b"A cute tiger from Thailand", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732240345069.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AVA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

