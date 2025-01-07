module 0x740f578b6b15252da123d03ffc3a0433627a904a72a56cb5e6fd3557d7ca93c9::nhu {
    struct NHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: NHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NHU>(arg0, 9, b"NHU", b"Ccc", b"Shjssjs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/de979a52-284c-46e4-8f6c-afa08419c1f2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

