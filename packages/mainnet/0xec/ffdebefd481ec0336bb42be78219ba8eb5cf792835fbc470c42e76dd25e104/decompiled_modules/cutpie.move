module 0xecffdebefd481ec0336bb42be78219ba8eb5cf792835fbc470c42e76dd25e104::cutpie {
    struct CUTPIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUTPIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUTPIE>(arg0, 6, b"CUTPIE", b"Cutie Pie", b"CUTEST DOG EVER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734308770960.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUTPIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUTPIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

