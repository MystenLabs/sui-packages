module 0xa3e4a895251f081916d07720580b64ad4fb88b3d99f54b025851f6fbc7ed9c8c::ending {
    struct ENDING has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENDING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENDING>(arg0, 6, b"ending", b"happy ending", b"happy endings", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732781291613.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ENDING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENDING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

