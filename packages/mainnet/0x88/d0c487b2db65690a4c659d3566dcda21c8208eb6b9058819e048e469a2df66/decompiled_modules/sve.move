module 0x88d0c487b2db65690a4c659d3566dcda21c8208eb6b9058819e048e469a2df66::sve {
    struct SVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SVE>(arg0, 6, b"SVE", b"Suiverse", b"SUIVERSE is a new ecosystem on the Sui blockchain specifically designed to protect your digital assets. Imagine a smart city in the digital world, where every transaction and asset is secured.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_97b76a94cf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

