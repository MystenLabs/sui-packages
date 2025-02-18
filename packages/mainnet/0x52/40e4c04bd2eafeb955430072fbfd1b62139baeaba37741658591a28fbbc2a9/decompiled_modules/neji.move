module 0x5240e4c04bd2eafeb955430072fbfd1b62139baeaba37741658591a28fbbc2a9::neji {
    struct NEJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEJI>(arg0, 9, b"NEJI", b"Neji Hyuga", b"ninja with unique skills!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/W54YRA5.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NEJI>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEJI>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

