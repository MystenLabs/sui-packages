module 0x2e8296a6f096748b03cb01abc42bfb01ad217d1910cb59c722aa4c0c217a3fdd::sticks {
    struct STICKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STICKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STICKS>(arg0, 9, b"STICKS", b"Sticks World", x"f09fa5a22047657420726561647920746f20737469636b2061726f756e642120f09fa5a2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.jsdelivr.net/gh/carpsui/projects@main/coin-logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STICKS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STICKS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STICKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

