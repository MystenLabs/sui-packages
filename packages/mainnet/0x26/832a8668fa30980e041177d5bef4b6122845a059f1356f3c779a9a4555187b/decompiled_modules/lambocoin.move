module 0x26832a8668fa30980e041177d5bef4b6122845a059f1356f3c779a9a4555187b::lambocoin {
    struct LAMBOCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMBOCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMBOCOIN>(arg0, 9, b"LAMBOCOIN", b"LAMBOCOIN ", b"Lamboooooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/75657431-f9f0-49ba-85ec-03e03f020531.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMBOCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAMBOCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

