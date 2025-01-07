module 0x3eaf54ed313e7127362c440a42138ef86cd1d822e33a7c05d6d5b264c6c56f5c::yapper {
    struct YAPPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAPPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAPPER>(arg0, 6, b"YAPPER", b"YapPer", x"224869212049276d20596170706572212049276d2038207965617273206f6c6420616e642049206c6f766520706c6179696e6720766964656f2067616d657320616e6420726964696e67206d792073636f6f7465722e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_16_49_56_4c82dc4614_407d2f2cda.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAPPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YAPPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

