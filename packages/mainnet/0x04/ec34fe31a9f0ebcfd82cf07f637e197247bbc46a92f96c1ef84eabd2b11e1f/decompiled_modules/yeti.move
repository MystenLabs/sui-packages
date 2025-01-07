module 0x4ec34fe31a9f0ebcfd82cf07f637e197247bbc46a92f96c1ef84eabd2b11e1f::yeti {
    struct YETI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YETI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YETI>(arg0, 6, b"YETI", b"Yeti on Sui", b"Meet yeti on Sui lofi big bully brother.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5894_29f1acd73b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YETI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YETI>>(v1);
    }

    // decompiled from Move bytecode v6
}

