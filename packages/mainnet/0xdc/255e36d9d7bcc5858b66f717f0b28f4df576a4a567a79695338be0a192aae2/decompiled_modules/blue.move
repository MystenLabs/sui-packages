module 0xdc255e36d9d7bcc5858b66f717f0b28f4df576a4a567a79695338be0a192aae2::blue {
    struct BLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUE>(arg0, 6, b"BLUE", b"blue on sui", b"blue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blue_fc26442cf6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

