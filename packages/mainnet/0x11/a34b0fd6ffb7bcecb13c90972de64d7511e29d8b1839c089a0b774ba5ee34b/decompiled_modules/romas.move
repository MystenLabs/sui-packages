module 0x11a34b0fd6ffb7bcecb13c90972de64d7511e29d8b1839c089a0b774ba5ee34b::romas {
    struct ROMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROMAS>(arg0, 5, b"ROMAS", b"Romas", b"No Face No Capital", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GFpAs0nXMAAiWM2?format=png&name=900x900")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ROMAS>(&mut v2, 69696969696900000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROMAS>>(v2, @0x31de120fb252bfef5d1441e9df5b172a6b5203efb8ba03453a4ccb2fc7ed1466);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

