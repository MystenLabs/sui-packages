module 0xa48b74b65b297aa6254c802ac0ccf4dd6437f43b4756d72464cb3ed7e1a7340f::suippy {
    struct SUIPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPPY>(arg0, 6, b"SUIPPY", b"Suippy", b"Let's seize the opportunity and develop together! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CORAL_SUI_607b6ad864.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

