module 0x2ade4a833bf92b0ae7c2fc0bdb3ebcac5562957f58574c7e6ef4e80263b0786a::nn {
    struct NN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NN>(arg0, 9, b"NN", b"NarutoN", b"Anime", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1e74d590-16de-4d56-92b9-88800e8da60d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NN>>(v1);
    }

    // decompiled from Move bytecode v6
}

