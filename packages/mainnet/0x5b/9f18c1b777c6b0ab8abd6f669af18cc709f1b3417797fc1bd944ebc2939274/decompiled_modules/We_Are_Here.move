module 0x5b9f18c1b777c6b0ab8abd6f669af18cc709f1b3417797fc1bd944ebc2939274::We_Are_Here {
    struct WE_ARE_HERE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WE_ARE_HERE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WE_ARE_HERE>(arg0, 9, b"WAH", b"We Are Here", b"we are over here only. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GzxS_N-XYAA11nh?format=jpg&name=4096x4096")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WE_ARE_HERE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WE_ARE_HERE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

