module 0x607aabe82cdc67d54ec882787fe6f483f76ece2ccb3ddd85b1a20ab5b439207a::barbie {
    struct BARBIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARBIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARBIE>(arg0, 9, b"BARBIE", b"BARBIE", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.wikia.nocookie.net/barbie-latina/images/4/47/6809393978_4e63b2fabd_z.jpg/revision/latest/smart/width/250/height/250?cb=20130930014059&path-prefix=es")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BARBIE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARBIE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARBIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

