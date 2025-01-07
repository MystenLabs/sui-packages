module 0x191dd34cee7ecfddbe1345a8b1be2f0b17f3b2f1c7777ed49b7279b6ca6bb82f::chip {
    struct CHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIP>(arg0, 6, b"CHIP", b"Sui Blue Chip", x"4120626c756520706f7461746f206d666572207374616e647320616c6f6e652061732074686520736f6c6520626c75652d63686970206d656d65636f696e206f6e20535549200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dov_00980f821c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

