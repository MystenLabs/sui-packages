module 0x2190b431b04c0dcddb3fc736279fd482c1871bf352abf5379fbb99da9cbca0d7::purr {
    struct PURR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURR>(arg0, 6, b"PURR", b"SUI_PURR", x"546865206d6f737420646f6d696e616e742063617420696e205355492065636f73797374656d2e2054686520507572726665637420436f696e20666f72207468652043727970746f20576f726c642e20535549707572723a2057686572652045766572792044617920697320436174757264617921204675722d7265616c204761696e73207769746820535549707572722120446f6ee280997420536c656570206f6e2054686973204361746e6170206f66205765616c746821204d656f7720746f20746865204d6f6f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737450807642.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PURR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

