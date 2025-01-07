module 0x24dffb6dc4793965eaca5b9917939a39c89069b1a5e103fff7d7c0325c14406a::robot {
    struct ROBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBOT>(arg0, 6, b"ROBOT", b"WE, ROBOT", b"This will be one for the history books @elonmusk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/YX_6_AKFP_0_400x400_86ccb563b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

