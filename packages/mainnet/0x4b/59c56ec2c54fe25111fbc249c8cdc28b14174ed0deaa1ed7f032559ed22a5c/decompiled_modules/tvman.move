module 0x4b59c56ec2c54fe25111fbc249c8cdc28b14174ed0deaa1ed7f032559ed22a5c::tvman {
    struct TVMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TVMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TVMAN>(arg0, 6, b"TVman", b"Sui TVman", b"Tvman on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9e14f42d_9356_409e_9f3b_6162f7a1a572_c848e7d129.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TVMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TVMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

