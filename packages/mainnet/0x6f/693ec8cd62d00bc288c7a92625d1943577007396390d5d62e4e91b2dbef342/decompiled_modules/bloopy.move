module 0x6f693ec8cd62d00bc288c7a92625d1943577007396390d5d62e4e91b2dbef342::bloopy {
    struct BLOOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOOPY>(arg0, 9, b"BLOOPY", b"BABY LOOPY", b"LOOPY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLOOPY>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOOPY>>(v2, @0x732c03d92710c08096a8e0316205b35d6e2d663cd70b1ba5a3cec682b68d6b09);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOOPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

