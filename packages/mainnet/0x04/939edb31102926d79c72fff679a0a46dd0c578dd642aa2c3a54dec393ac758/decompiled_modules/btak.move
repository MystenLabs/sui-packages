module 0x4939edb31102926d79c72fff679a0a46dd0c578dd642aa2c3a54dec393ac758::btak {
    struct BTAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTAK>(arg0, 9, b"BTAK", b"BOTAKS", b"Botak gundul plontos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d8820b74-b53d-433b-8142-b674ef3ad9a6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

