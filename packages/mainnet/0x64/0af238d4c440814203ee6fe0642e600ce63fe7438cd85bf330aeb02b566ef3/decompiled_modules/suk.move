module 0x640af238d4c440814203ee6fe0642e600ce63fe7438cd85bf330aeb02b566ef3::suk {
    struct SUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUK>(arg0, 6, b"SUK", b"suik", b"ZZZZZZZZZZZZZZZ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O_Ta9c_J2_C_400x400_97fd22badc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

