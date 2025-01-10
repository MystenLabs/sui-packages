module 0xd0d962f08d28ba0ab6e73d36d830c016731ff0e5b51320f1e61a60f42600871e::gmd {
    struct GMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMD>(arg0, 9, b"GMD", b"Ghost Mad", b"Be a ghost - No one else can see through you, no one should be able to read your abilities, character, mindest, thinking whatever. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/055e7ce8-79d7-494b-b54b-d7d10887d25b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GMD>>(v1);
    }

    // decompiled from Move bytecode v6
}

