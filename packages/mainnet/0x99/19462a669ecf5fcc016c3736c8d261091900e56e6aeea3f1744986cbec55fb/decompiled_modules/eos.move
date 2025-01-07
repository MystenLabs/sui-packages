module 0x9919462a669ecf5fcc016c3736c8d261091900e56e6aeea3f1744986cbec55fb::eos {
    struct EOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EOS>(arg0, 6, b"EOS", b"Edwin Online SUI", x"5768656e206d616e206d6565747320616e696d616c7320796f752067657420456477696e204f6e6c696e652c207573656420627920736f6d652c206c6f766564206279206d616e792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241217_093131_209_7ddbe8f06e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

