module 0x36a63ec85ca21cbb86002bef560b3f96f1dee47e0b3cb48db50e99d8d38dd1bc::coks {
    struct COKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: COKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COKS>(arg0, 6, b"COKS", b"Cat Own Kimono on SUI", b"$COK is the First Cat Memecoin Launched On SUI, Created by the $WIF Team. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/j_Le_2lo_400x400_b199916fd1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

