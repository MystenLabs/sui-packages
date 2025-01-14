module 0xe97075415a2643faf1b0f0fa4829a0af0cca74d85136c1a5d48291f26355ee0f::talk {
    struct TALK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TALK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TALK>(arg0, 6, b"TALK", b"Word Of Mouth", b"No Socials, No BS. Just an organically grown community built through the power of human connection", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736812016878.38")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TALK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TALK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

