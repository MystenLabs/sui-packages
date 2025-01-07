module 0x5d7db2c974ec2f8dda5227ea3b8cd94ab6a1a3c6cb90fd3fb9ac3302c6ccbb09::buddy {
    struct BUDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUDDY>(arg0, 6, b"BUDDY", b"BASE BUDDY", b"Building a Platform of Battles for any Token!! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_Twi_Ax_SE_400x400_ffc3071f5e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

