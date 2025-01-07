module 0x762e6a4e0fc0f148ba68907d82df33035e83e4d9d282b2cb4eeaeda8976888e4::broken {
    struct BROKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROKEN>(arg0, 9, b"BROKEN", b"SITE404", b"did we really break the site?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ih1.redbubble.net/image.5139271799.1747/bg,f8f8f8-flat,750x,075,f-pad,750x1000,f8f8f8.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BROKEN>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROKEN>>(v2, @0x1287280ae3ec05a4ba76a450a51c002b336ffe84926f3213e85468add27d6e5e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

