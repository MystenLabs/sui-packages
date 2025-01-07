module 0xd506e1a7a9f85cc75603c6729de764333b3a943f463fab43a11cd812fb12a803::bdn {
    struct BDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDN>(arg0, 6, b"BDN", b"Big Digger Nick", b"Biggest miner in town. Big Digger Nick", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ffwerfbg4g34r34t3gdfg_5280e6a9c6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

