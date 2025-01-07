module 0x13f753ebb6beadb16b8a289add7570141320086822d4756ac84c83a4e639e792::sal9 {
    struct SAL9 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAL9, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAL9>(arg0, 9, b"SAL9", b"Salau Cat", b"Sal token for the cat lovers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/81515a23-fce6-4dc4-b99c-1e428b029cdf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAL9>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAL9>>(v1);
    }

    // decompiled from Move bytecode v6
}

