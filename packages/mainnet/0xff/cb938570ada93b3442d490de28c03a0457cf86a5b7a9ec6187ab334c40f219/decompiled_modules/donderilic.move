module 0xffcb938570ada93b3442d490de28c03a0457cf86a5b7a9ec6187ab334c40f219::donderilic {
    struct DONDERILIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONDERILIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONDERILIC>(arg0, 6, b"Donderilic", b"Derilic", b"Just for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidcuabk22cjy76nw4vt3ztqmxjo6ghv65mwwj2tf7xlg2rus3r3z4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONDERILIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DONDERILIC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

