module 0x59cd869431b048753a8028cd65ffbc6cb2117d2805dcf794f727ddd0c0b706da::edd {
    struct EDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDD>(arg0, 9, b"EDD", b"EDUAD", b"A token that describe eduad life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c54e85f3-4462-4f40-9e96-0357338ae2d7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

