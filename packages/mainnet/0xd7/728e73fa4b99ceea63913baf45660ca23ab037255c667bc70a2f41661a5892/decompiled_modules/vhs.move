module 0xd7728e73fa4b99ceea63913baf45660ca23ab037255c667bc70a2f41661a5892::vhs {
    struct VHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VHS>(arg0, 6, b"VHS", b"Vampire Hunter Sui", b"Welcome to the night. This token isn't just a piece of code; it's your ticket to an eternal hunt for glory, wealth, and perhaps, a bit of your soul. Holders are part of a community committed to slaying digital vampires and protecting your portfolios.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734045003416.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VHS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VHS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

