module 0xd2c594a9a4b05d9aa4094c7d8f4f0a8551706d75e9b049a8447bb2f9dd0121d5::c {
    struct C has drop {
        dummy_field: bool,
    }

    fun init(arg0: C, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<C>(arg0, 9, b"C", b"CCC", b"To moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c8dac7a8-cc11-455d-84bc-37a8cabb46a6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<C>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<C>>(v1);
    }

    // decompiled from Move bytecode v6
}

