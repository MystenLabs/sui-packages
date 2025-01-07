module 0xf3f22850c0703b90042a2ccfd5f14aee0f9b7a9a69ead4d6b299794cd9cae25c::jjkka {
    struct JJKKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: JJKKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JJKKA>(arg0, 9, b"JJKKA", b"Jkka", b"Joona", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/14b6975d-ff78-4a68-9c85-c3158129ce53.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JJKKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JJKKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

