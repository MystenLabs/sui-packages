module 0x484bd73daf357124655852607f512ebdcbc97011b248c125b7373d58f00b004::spooky {
    struct SPOOKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOOKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOOKY>(arg0, 6, b"SPOOKY", b"HALLOWEEN", b"You can run but you cant hide  !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_200_x_200_px_b2c86d19a4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOOKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOOKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

