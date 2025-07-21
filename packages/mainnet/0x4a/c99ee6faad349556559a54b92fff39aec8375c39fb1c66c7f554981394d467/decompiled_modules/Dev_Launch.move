module 0x4ac99ee6faad349556559a54b92fff39aec8375c39fb1c66c7f554981394d467::Dev_Launch {
    struct DEV_LAUNCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEV_LAUNCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEV_LAUNCH>(arg0, 9, b"DEV", b"Dev Launch", b"this is a dev coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1231898940905144323/knjj2pYl_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEV_LAUNCH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEV_LAUNCH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

