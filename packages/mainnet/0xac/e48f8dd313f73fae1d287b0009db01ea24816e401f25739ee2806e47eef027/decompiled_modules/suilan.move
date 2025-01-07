module 0xace48f8dd313f73fae1d287b0009db01ea24816e401f25739ee2806e47eef027::suilan {
    struct SUILAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILAN>(arg0, 9, b"SUILAN", b"SLN", b"Best and newa meme coin on sui chai with minimum of total supply sui can hit 0.002 after lunch our web3 gaming system and NFT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bd68b0e3-18b6-4008-8d7c-9dcaf2015489.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUILAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

