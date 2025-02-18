module 0xc74bb808905fed9383228407f3b4376e6fa9b753d078b8e4aa33c9e7b75c2eb::zeus {
    struct ZEUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEUS>(arg0, 9, b"ZEUS", b"Zeus", b"Could be a God?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/0Eu8u86.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ZEUS>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEUS>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZEUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

