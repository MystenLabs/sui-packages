module 0x46a2c8cc9db403554459597ccfbe981bdd1ab478ab78b5d8ee708e079cb5a37e::stoic {
    struct STOIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STOIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STOIC>(arg0, 6, b"STOIC", b"Stoicism", b"PEACE THROUGH ACCEPTANCE & CONTROL, SUIIIIIIIIII.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/stoicism_2eb5e91d31.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STOIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STOIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

