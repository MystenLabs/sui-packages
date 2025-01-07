module 0xb597f0ceff00927d708b42e5f5dc59e4fedbc53a41538f0317bbe20869bbad62::krm {
    struct KRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRM>(arg0, 9, b"KRM", b"KARMA", b"Each owner of the $KARMA token cleanses his karma from negativity, and the owners of special NFTs accumulate positive karma", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fcf7790b-1289-49bd-9cd7-67f6e2b6830d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

