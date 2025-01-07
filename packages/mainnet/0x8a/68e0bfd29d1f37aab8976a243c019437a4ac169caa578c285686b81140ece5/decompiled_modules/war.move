module 0x8a68e0bfd29d1f37aab8976a243c019437a4ac169caa578c285686b81140ece5::war {
    struct WAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAR>(arg0, 9, b"WAR", b"Warius", b"Warius ok", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/01b44bd6-19e8-4418-af9f-3dd281151eaf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

