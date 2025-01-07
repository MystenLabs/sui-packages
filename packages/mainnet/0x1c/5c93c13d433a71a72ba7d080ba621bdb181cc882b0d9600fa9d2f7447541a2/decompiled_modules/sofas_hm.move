module 0x1c5c93c13d433a71a72ba7d080ba621bdb181cc882b0d9600fa9d2f7447541a2::sofas_hm {
    struct SOFAS_HM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOFAS_HM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOFAS_HM>(arg0, 9, b"SOFAS_HM", b"SZOFA", b"Great news SOFA is coming in market and it is boooooom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/29c99300-b9a2-4f2c-9183-23e019214cb6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOFAS_HM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOFAS_HM>>(v1);
    }

    // decompiled from Move bytecode v6
}

