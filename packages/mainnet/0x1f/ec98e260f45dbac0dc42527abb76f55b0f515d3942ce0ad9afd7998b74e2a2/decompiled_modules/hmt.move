module 0x1fec98e260f45dbac0dc42527abb76f55b0f515d3942ce0ad9afd7998b74e2a2::hmt {
    struct HMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMT>(arg0, 9, b"HMT", b"HAMSTER", b"rat meme , fully owned by the community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f48367b9-19f1-466d-9e81-2fd6831a8df0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HMT>>(v1);
    }

    // decompiled from Move bytecode v6
}

