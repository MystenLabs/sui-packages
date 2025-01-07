module 0x94974d50389246f4ec9ce75356dfd97ef9deb7a0ac30fb7dc53e7da5857b1b4f::dsg {
    struct DSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSG>(arg0, 9, b"DSG", b"FSG", b"GDS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/04f5a96f-8efc-473d-89d2-d4034418f360.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DSG>>(v1);
    }

    // decompiled from Move bytecode v6
}

