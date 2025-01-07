module 0x2faa596651de683c659cf77ce3e3f71512706c1ac9cabfa45d5ff427e737a2ad::decry {
    struct DECRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DECRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DECRY>(arg0, 9, b"DECRY", b"De cryp", b"Community token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9f8d43c3-ecb4-4391-b366-d9a0272d88f0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DECRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DECRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

