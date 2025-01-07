module 0xf68238778b4e49fe4958a1c648da565526d7c24b41dc7139c465935241fcbd1b::aran {
    struct ARAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARAN>(arg0, 9, b"ARAN", b"aran", b"aranairdrop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e6cfe11d-9c4a-4114-a88e-4e17f621bf27.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

