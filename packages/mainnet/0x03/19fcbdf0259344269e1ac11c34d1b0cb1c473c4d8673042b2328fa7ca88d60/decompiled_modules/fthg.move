module 0x319fcbdf0259344269e1ac11c34d1b0cb1c473c4d8673042b2328fa7ca88d60::fthg {
    struct FTHG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTHG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FTHG>(arg0, 9, b"FTHG", b"Faith", b"Claim and cool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fbe40611-d120-4e18-b66c-9bb9617521d1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FTHG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FTHG>>(v1);
    }

    // decompiled from Move bytecode v6
}

