module 0x8dc0745cbf667bd6f94dbe17a069c1809ecf7e1c15829acf57656aa2d8ffff36::chip {
    struct CHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIP>(arg0, 6, b"CHIP", b"Chippy The Chip", x"43484950505920495320544845204f4646494349414c20554e4f4646494349414c204d4153434f54204f46205355492e2048452753205448452043555445535420534341524544204c4954544c4520424c554520424c4f42204f4e20544845204d4f535420424c5545204e4554574f524b2e204845204c494b455320544f204d41582042494420414e442052554e2041574159210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5af74d0e7770f83770186b71f427bd2a_79bcdb1457.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

