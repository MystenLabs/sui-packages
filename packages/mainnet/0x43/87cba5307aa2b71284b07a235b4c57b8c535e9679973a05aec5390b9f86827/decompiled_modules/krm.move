module 0x4387cba5307aa2b71284b07a235b4c57b8c535e9679973a05aec5390b9f86827::krm {
    struct KRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRM>(arg0, 9, b"KRM", b"KARMA", b"Each owner of the $KARMA token cleanses his karma from negativity, and the owners of special NFTs accumulate positive karma", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/313f1d75-b9dd-4d50-b488-fc6682f2aad1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

