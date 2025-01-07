module 0xcccae7c707b60eb9830c52935330f9d863f479c26b8870058ae84a7ed9fcf84d::tgs {
    struct TGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGS>(arg0, 9, b"TGS", b"SAD TREE", b"A SAD AND DIM TREE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/16d9783e-eee5-4ef8-94e2-73b0e4793b50.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

