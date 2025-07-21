module 0x3ab357601a601dfc51fc3e8d8f39916a6374e57b1a4cebb307b6e3de8cc86ca3::dev {
    struct DEV has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEV>(arg0, 9, b"DEV", b"dev", b"just a dev coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1231898940905144323/knjj2pYl_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEV>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

