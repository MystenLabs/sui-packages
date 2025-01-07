module 0x510e449a365185915b17d5bd6d4ef153c980a8926e872982baa6dc1c031aa515::suibome {
    struct SUIBOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBOME>(arg0, 6, b"Suibome", b"bome", x"54686520737569626f6d65206d656d652077696c6c20646566696e6974656c79206265206e756d626572206f6e650a0a70756d70756d70756d7070756d7070756d70", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8887_ff7abb9de9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBOME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBOME>>(v1);
    }

    // decompiled from Move bytecode v6
}

