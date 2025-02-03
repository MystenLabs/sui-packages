module 0xd87cc03142e8d055d2f51ee2eb8527620bf0b5895151ae9f8bf53c2ce5fb99c6::blux {
    struct BLUX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUX>(arg0, 6, b"BLUX", b"BLUXX", b"$BLUX is a speculative token for the Sui Community on X.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738570419834.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

