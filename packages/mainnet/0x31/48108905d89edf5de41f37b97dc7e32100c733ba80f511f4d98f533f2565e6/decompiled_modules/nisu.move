module 0x3148108905d89edf5de41f37b97dc7e32100c733ba80f511f4d98f533f2565e6::nisu {
    struct NISU has drop {
        dummy_field: bool,
    }

    fun init(arg0: NISU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NISU>(arg0, 6, b"NISU", b"NISU THE CAT", b"Relaunch fixed twitter and website ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nisu_e97d23547a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NISU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NISU>>(v1);
    }

    // decompiled from Move bytecode v6
}

