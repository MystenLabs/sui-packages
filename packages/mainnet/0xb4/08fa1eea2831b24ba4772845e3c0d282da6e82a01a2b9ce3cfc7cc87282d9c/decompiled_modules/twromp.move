module 0xb408fa1eea2831b24ba4772845e3c0d282da6e82a01a2b9ce3cfc7cc87282d9c::twromp {
    struct TWROMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWROMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWROMP>(arg0, 6, b"TWROMP", b"TWROMP THE PRESIDENT", b"Bwroke? Don't be Dwomp. Get sum $TWROMP and join the bull run wave made by Trump!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1731419970578_ae9a5efc2c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWROMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWROMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

