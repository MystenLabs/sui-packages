module 0x9c9ee0afc1a829f136043315f69fa6c7c8ed6023c9782068ca9274a6528aae42::wizcat {
    struct WIZCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIZCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIZCAT>(arg0, 6, b"WIZCAT", b"WIZARD Cat", b"First WIZARD Cat on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_9_6080319250.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIZCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIZCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

