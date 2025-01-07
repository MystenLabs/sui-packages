module 0xbb569ce0847f20483a5b08ff840bb3bff9bdcd87f9481fdb9b0847cc731431e0::prp {
    struct PRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRP>(arg0, 9, b"PRP", b"purple", x"5368696e65207769746820507572706c65436f696e3a2054686520726f79616c2063727970746f63757272656e637920746861742773206d616a657374696320696e2069747320706572666f726d616e63652c2064656c69766572696e6720726567616c2070726f6669747320616e642063726f776e696e6720796f757220706f7274666f6c696f2077697468206120746f756368206f66206c75787572792120f09f9191f09f929c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/033662ce-77b8-43db-9b51-b0129a8b0f38.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRP>>(v1);
    }

    // decompiled from Move bytecode v6
}

