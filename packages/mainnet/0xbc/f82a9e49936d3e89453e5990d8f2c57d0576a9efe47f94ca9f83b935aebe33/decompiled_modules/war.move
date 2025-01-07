module 0xbcf82a9e49936d3e89453e5990d8f2c57d0576a9efe47f94ca9f83b935aebe33::war {
    struct WAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAR>(arg0, 6, b"War", b"No War", b"there's only life when there's no war", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/indir_d410147da5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

