module 0x63d699f6daf7b22237081840b8de0a6d5928bf461d4f2ffa97aa27b47c8bae96::sudog {
    struct SUDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUDOG>(arg0, 6, b"SUDOG", b"Sudog", b"Sudog is a groundbreaking memecoin on the Sui blockchain, designed to build a strong, active, and engaged community. Our mission is to create an evolving ecosystem where users can collaborate, share ideas, and grow together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241222_142335_dee67bc320.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

