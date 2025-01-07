module 0x35f9694f6f7f0b984be0366953085ac1e9c4110e0c19dea0c46bc0e99daaccaa::nampervn {
    struct NAMPERVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAMPERVN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAMPERVN>(arg0, 9, b"NAMPERVN", b"NamPer", b"NamPerVn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bef08eb5-16ab-4f03-a4d9-d6a112fe3dbd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAMPERVN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAMPERVN>>(v1);
    }

    // decompiled from Move bytecode v6
}

