module 0x5fb068dc6e424be147d2c4cb19fa224df42e7ea17d00262b8b2c384e2e1f4be::nns {
    struct NNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NNS>(arg0, 6, b"NNS", b"New Noble SUI", b"New Noble SUI is a revolutionary new product with the same extraordinary potential as the SUI network, has made a stunning debut. Sourced from a rare and pristine water source, it undergoes purification through cutting-edge technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750121588235.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NNS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NNS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

