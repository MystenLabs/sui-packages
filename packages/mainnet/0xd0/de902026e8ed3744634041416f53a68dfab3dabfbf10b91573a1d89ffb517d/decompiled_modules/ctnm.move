module 0xd0de902026e8ed3744634041416f53a68dfab3dabfbf10b91573a1d89ffb517d::ctnm {
    struct CTNM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTNM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTNM>(arg0, 6, b"CTNM", b"Captain Moodeng", x"4341505441494e20204d4f4f44454e470a4f6e6520736d616c6c207374657020666f72206d616e2c206f6e65206769616e74206c65617020666f72204d6f6f64656e672e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_14_34_48_01c8798d1c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTNM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTNM>>(v1);
    }

    // decompiled from Move bytecode v6
}

