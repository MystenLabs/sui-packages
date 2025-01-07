module 0xb548b7a598057b5988ca1029f009cc21f20b3fd06c3ca735a87a0d0922fb7797::betc {
    struct BETC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BETC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BETC>(arg0, 9, b"BETC", b"Beluga", b"Beluga  the Cat Token of Adventure ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/94d82eae-912b-4df1-a533-3c80586add24.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BETC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BETC>>(v1);
    }

    // decompiled from Move bytecode v6
}

