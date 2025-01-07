module 0x3ee3a7ac98377a4d2eb8980ea27d3b8e0781d2579a4124d784d0379d898fe56b::smcat {
    struct SMCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMCAT>(arg0, 6, b"SMCAT", b"Super Mario Cat", b"PLAY GAME SITE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mariocat_7d293cf91c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

