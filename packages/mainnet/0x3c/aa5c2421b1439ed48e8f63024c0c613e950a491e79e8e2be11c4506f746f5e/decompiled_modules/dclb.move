module 0x3caa5c2421b1439ed48e8f63024c0c613e950a491e79e8e2be11c4506f746f5e::dclb {
    struct DCLB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCLB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCLB>(arg0, 2, b"DCLB", b"DCL BRAND", b"Owner of street and luxury brands", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arivmarketplace.sirv.com/Restaurant%20Images/yy.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DCLB>(&mut v2, 12000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCLB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DCLB>>(v1);
    }

    // decompiled from Move bytecode v6
}

