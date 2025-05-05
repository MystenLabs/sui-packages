module 0x96318f586b337bd1dccc973e1d526dedecae6700dbef71e60dd7d8cba614006a::smg {
    struct SMG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMG>(arg0, 6, b"SMG", b"SUIMAN GROUP", b"LET'S FILL THIS GREAT SPACE WITH RHYTHM TOGETHER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_df32c9f0b2.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMG>>(v1);
    }

    // decompiled from Move bytecode v6
}

