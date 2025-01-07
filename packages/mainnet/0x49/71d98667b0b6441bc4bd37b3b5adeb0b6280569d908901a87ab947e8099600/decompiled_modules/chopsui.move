module 0x4971d98667b0b6441bc4bd37b3b5adeb0b6280569d908901a87ab947e8099600::chopsui {
    struct CHOPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOPSUI>(arg0, 6, b"CHOPSUI", b"Chop SUI", b"CHOP SUI Bitch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CHOP_236bbf111b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

