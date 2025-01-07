module 0x723c22840e03c592821403f55193411efe3feb13af311b54c5af074a68437d55::bbw {
    struct BBW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBW>(arg0, 6, b"BBW", b"Beeg Blue Whale", x"4d616b6520776176657320696e207468652063727970746f207365610a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bull_BEEG_09ab305620.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBW>>(v1);
    }

    // decompiled from Move bytecode v6
}

