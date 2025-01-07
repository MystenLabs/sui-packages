module 0xadabf82bf04d03220470fd4d282982acde938ee8b05d76ecedb5d5e489431c91::gmcoin {
    struct GMCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMCOIN>(arg0, 9, b"GMCOIN", b"GMC", b"Community token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c4a2045b-3d4e-46b4-bfae-c091189ab7c1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GMCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

