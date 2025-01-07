module 0xddd61e147b1d576566d5fa2f80c87f194daf105d9cb0768195a587094f28053d::to1 {
    struct TO1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TO1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TO1>(arg0, 6, b"TO1", b"TOOD", b"IS ASDA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241013225055_7e7d76d45f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TO1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TO1>>(v1);
    }

    // decompiled from Move bytecode v6
}

