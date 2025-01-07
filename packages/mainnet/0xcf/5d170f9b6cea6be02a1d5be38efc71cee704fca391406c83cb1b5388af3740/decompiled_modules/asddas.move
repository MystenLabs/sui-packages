module 0xcf5d170f9b6cea6be02a1d5be38efc71cee704fca391406c83cb1b5388af3740::asddas {
    struct ASDDAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDDAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDDAS>(arg0, 9, b"ASDDAS", b"ASADS", b"FASA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/be50bf4d-eaed-4f5a-b993-6cfce4dd4839.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDDAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASDDAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

