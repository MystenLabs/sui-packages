module 0x32d54d93b2db8172b150349ca4faa5b8e976d2dab7bdfb9e6118a4298a7fb5e1::gg {
    struct GG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GG>(arg0, 9, b"GG", b"GiraffeGol", x"20436f696e732061732074616c6c20617320612067697261666665e2809973206e65636b2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b64b3bcd-3875-4b56-826e-e285e58b04ec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GG>>(v1);
    }

    // decompiled from Move bytecode v6
}

