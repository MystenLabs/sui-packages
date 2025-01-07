module 0xe602add2135174b927ddceaacb0e1b62f8d76b9715549fbb18e047318bbed789::dogtongue {
    struct DOGTONGUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGTONGUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGTONGUE>(arg0, 6, b"DOGTONGUE", b"DOGTONGUE SUI", x"24444f47544f4e4755450a0a24444f47544f4e475545206973206865726520746f2074616b65207061727420696e207468650a63727970746f20776f726c64212077616e7420746f2062652074686520626967676573740a616e642074686520626573742c20626520707265706172656420666f72206269670a737572707269736573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000752_49b4db9230.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGTONGUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGTONGUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

