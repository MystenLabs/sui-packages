module 0x736fcb513ec6a2b26bc25ed18d719f36d6a767105f624eb5c2c5436cb42cf4b7::pimling {
    struct PIMLING has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIMLING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIMLING>(arg0, 6, b"PIMLING", b"Sui pimling", b"Pim is the eternally optimistic and cheerful character from Smiling Friends Inc., where he works alongside his best friend Charlie to spread happiness throughout the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048509_1af86af70e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIMLING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIMLING>>(v1);
    }

    // decompiled from Move bytecode v6
}

