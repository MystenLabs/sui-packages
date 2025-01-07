module 0xcce7455b2669875a23abdfe212bca8e9ae3782b81bb8274d2f504e4f1eea851b::azcoin {
    struct AZCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AZCOIN>(arg0, 9, b"AZCOIN", b"Az", b"Azcoin meme token. Buy meme token in your wallet ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/417ee0dd-fe76-45b9-bd1f-ff77e0fe779f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AZCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

