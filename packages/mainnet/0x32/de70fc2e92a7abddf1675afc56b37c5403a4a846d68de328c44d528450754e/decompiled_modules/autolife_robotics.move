module 0x32de70fc2e92a7abddf1675afc56b37c5403a4a846d68de328c44d528450754e::autolife_robotics {
    struct AUTOLIFE_ROBOTICS has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<AUTOLIFE_ROBOTICS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AUTOLIFE_ROBOTICS>>(0x2::coin::mint<AUTOLIFE_ROBOTICS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: AUTOLIFE_ROBOTICS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUTOLIFE_ROBOTICS>(arg0, 6, b"AUTOLFIE", b"autolife robotics", b"First ai robot coin on sui net by autolife robotics", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.autolife.ai/icon.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AUTOLIFE_ROBOTICS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUTOLIFE_ROBOTICS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

