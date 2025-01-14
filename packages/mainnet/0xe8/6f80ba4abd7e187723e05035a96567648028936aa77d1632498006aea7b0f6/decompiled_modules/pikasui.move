module 0xe86f80ba4abd7e187723e05035a96567648028936aa77d1632498006aea7b0f6::pikasui {
    struct PIKASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKASUI>(arg0, 6, b"PikaSui", b"Pika on SUI", b"Pikachu has arrived on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736896308713.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIKASUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKASUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

