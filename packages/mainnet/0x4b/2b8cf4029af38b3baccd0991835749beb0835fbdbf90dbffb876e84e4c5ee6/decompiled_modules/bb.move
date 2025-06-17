module 0x4b2b8cf4029af38b3baccd0991835749beb0835fbdbf90dbffb876e84e4c5ee6::bb {
    struct BB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BB>(arg0, 9, b"BB", b"BB", b"fdgfdsffdsfdsdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.bananatool.com/logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BB>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BB>>(v2, @0x51005de2c1b011205fe5719a79468feb94808cda0615c4772a466c965ef80c37);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BB>>(v1);
    }

    // decompiled from Move bytecode v6
}

