module 0x88bfbed19bb1018b1ddb0ab72ef5d911c115d9f532f4cf72901659819d1b656c::dolin {
    struct DOLIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLIN>(arg0, 9, b"DOLIN", b"HARDOLIN", b"Dahar modol ulin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/432e32c2-e639-4591-a46b-182a1de88595.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOLIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

