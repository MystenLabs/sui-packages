module 0x48021d0e097ea630c4bfbe4a95e18d200adaa3db2ad045a8988b9013e9bcdeff::amigos {
    struct AMIGOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMIGOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMIGOS>(arg0, 6, b"AMIGOS", b"Amigos On Sui", b"Amigos the meme coin on sui thats so laid-back, its practically horizontal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001831_82d6a6f042.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMIGOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMIGOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

