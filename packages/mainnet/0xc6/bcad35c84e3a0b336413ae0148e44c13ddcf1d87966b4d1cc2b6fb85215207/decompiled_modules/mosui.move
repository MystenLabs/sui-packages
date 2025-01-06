module 0xc6bcad35c84e3a0b336413ae0148e44c13ddcf1d87966b4d1cc2b6fb85215207::mosui {
    struct MOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOSUI>(arg0, 9, b"MOSUI", b"Moo deng", b"Moo deng ini terinspirasi dari hewan yang menggemaskan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7962dba6-3d3c-4c78-879c-c074f1b5bdb4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

