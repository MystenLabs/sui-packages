module 0x7a76bfc8581a2d342341265e2ee53992dda1da856ea20b1bfeabac2c173f25b2::super {
    struct SUPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPER>(arg0, 6, b"SUPER", b"Super SUI", x"5355504552206f6e205355492063616d65206865726520746f206d616b6520706561636520696e73696465207468652053554920426c6f636b636861696e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/super_sui_5e330be1db.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

