module 0xa147d3e4bd9b0a0da807c12f131ab8e0429dc70dcc02a4882dd2a258a949d05c::banana {
    struct BANANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANANA>(arg0, 6, b"BANANA", b"Banana Game", b"We are the BANANA GAME,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidpdhdljwxh5sdkum7hswhtmda2vm3au2ehi5fadqsnxcyjtzb5aa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BANANA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

