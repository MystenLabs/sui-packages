module 0x1cf571c330d7df8cb90a883e7b47c27257f733b00cf993f12864b452d6848016::boi {
    struct BOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOI>(arg0, 6, b"Boi", b"Boi on Sui", b"good boi of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/u_Jo_G_Fof7_400x400_22036a05b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

