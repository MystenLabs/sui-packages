module 0x9648ad2c893d42ff392842bfdee6489207b0fc8b3e17425d11e2de69ef08cc06::omgc {
    struct OMGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMGC>(arg0, 9, b"OMGC", b"OIMAIGOT", b"oivaicalon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/37f42dd1-a8ec-4a75-9fb2-4d7c01572551.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMGC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OMGC>>(v1);
    }

    // decompiled from Move bytecode v6
}

