module 0xb0367ed6044c112dd867581b5501562378f3e204a9e9d26e78232d06fb034677::dropcat {
    struct DROPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROPCAT>(arg0, 6, b"DROPCAT", b"DROP, THE CAT", b"The official memecoin of the game SPACE ORDIMAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4414_8cab17955a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DROPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

