module 0x53ea64da117ff14383067ad27c07929d7c69036655b47d210996106c608e400c::MyconidSensors {
    struct MYCONIDSENSORS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYCONIDSENSORS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYCONIDSENSORS>(arg0, 0, b"COS", b"Myconid Sensors", b"The Others look at you... envying what they do not have.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Myconid_Sensors.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYCONIDSENSORS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYCONIDSENSORS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

