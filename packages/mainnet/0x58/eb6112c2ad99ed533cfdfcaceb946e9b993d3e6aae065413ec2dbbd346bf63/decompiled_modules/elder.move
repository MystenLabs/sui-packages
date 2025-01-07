module 0x58eb6112c2ad99ed533cfdfcaceb946e9b993d3e6aae065413ec2dbbd346bf63::elder {
    struct ELDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELDER>(arg0, 9, b"ELDER", b"Elder sui", b"gem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHgdewCzacQwecejmP7_wlvNVydx9-PtNCIg&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ELDER>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELDER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

