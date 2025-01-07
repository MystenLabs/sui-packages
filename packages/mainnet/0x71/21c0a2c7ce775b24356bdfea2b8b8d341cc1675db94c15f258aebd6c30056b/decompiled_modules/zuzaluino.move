module 0x7121c0a2c7ce775b24356bdfea2b8b8d341cc1675db94c15f258aebd6c30056b::zuzaluino {
    struct ZUZALUINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUZALUINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUZALUINO>(arg0, 9, b"ZUZALUINO", b"Zuzalu", b"$ZUZALU is Vitalik Buterin's leading memecoin! Named after his Zuzalu project, it features a mascot inspired by Vitalik's own dog that was rescued by the people of Zuzalu.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bf0b515c-b182-41a6-a357-bf54d385f052.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUZALUINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZUZALUINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

