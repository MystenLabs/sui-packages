module 0x29f6ca58c8815559effb7fc240413b4ac20c70e0853ac2d21762cba3ee0b021f::krm {
    struct KRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRM>(arg0, 9, b"KRM", b"KARMA", b"Each owner of the $KARMA token cleanses his karma from negativity, and the owners of special NFTs accumulate positive karma", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e1b00a58-af75-43f4-a479-1b8abcdc0942.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

