module 0xcf80f4278600031caeed3e8ebfcc261693bd05f958a4298ff3e69d1eeac2bfc5::Dude {
    struct DUDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUDE>(arg0, 9, b"DUDE", b"Dude", b"just a dude.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Gz2fex8XUAAHWxf?format=jpg&name=900x900")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUDE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUDE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

