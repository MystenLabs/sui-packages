module 0x69aad48e72cc6210e0c9705c61dd0990a6dffdf8ca4883ef1763d30723ec367c::memek {
    struct MEMEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK>(arg0, 9, b"MEMEK", b"AIRDROP", b"Spesialis Airdrop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/886cbb7e-f0c2-4e37-b968-a0641a7a04cb-1000231035.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

