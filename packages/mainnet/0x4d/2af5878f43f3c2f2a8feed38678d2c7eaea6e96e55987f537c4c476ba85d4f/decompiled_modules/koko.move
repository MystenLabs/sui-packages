module 0x4d2af5878f43f3c2f2a8feed38678d2c7eaea6e96e55987f537c4c476ba85d4f::koko {
    struct KOKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOKO>(arg0, 9, b"KOKO", b"kiki", b"ooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.thenounproject.com/png/447685-200.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

