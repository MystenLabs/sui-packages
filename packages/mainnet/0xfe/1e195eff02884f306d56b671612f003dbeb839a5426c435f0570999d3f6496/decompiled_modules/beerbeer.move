module 0xfe1e195eff02884f306d56b671612f003dbeb839a5426c435f0570999d3f6496::beerbeer {
    struct BEERBEER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEERBEER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEERBEER>(arg0, 9, b"BEERBEER", b"Beer", b"Everyone loves beer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/36a7d01a-8934-4cee-b5c3-e1196d891856.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEERBEER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEERBEER>>(v1);
    }

    // decompiled from Move bytecode v6
}

