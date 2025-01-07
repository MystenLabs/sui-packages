module 0x232fe677739fa6146aec422923b483c7eec428c3c645b8bc3b74fc0d64bd0657::durka {
    struct DURKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DURKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DURKA>(arg0, 9, b"DURKA", b"Durdom", x"557021212120e2ad90e2ad90e2ad90", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/acfeac97-10b3-4cdc-bc6e-93c1b5c589d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DURKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DURKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

