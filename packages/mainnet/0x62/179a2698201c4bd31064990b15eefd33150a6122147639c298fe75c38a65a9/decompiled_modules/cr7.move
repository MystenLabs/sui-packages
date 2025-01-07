module 0x62179a2698201c4bd31064990b15eefd33150a6122147639c298fe75c38a65a9::cr7 {
    struct CR7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CR7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CR7>(arg0, 6, b"CR7", b"SIUUU", b"SIUUU - The ultimate meme coin that brings together the unstoppable energy of CR7 and the cutting-edge tech of the Sui Network!  With every transaction, you are not just riding the wave of the latest crypto trend, you are celebrating the legendary goal-celebration moves and the lightning-fast performance of the Sui blockchain. Whether you are a football fan or a crypto enthusiast, SIUUU is your ticket to a fun and dynamic community where every trade feels like scoring a hat-trick! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SIUUU_4748aa53db.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CR7>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CR7>>(v1);
    }

    // decompiled from Move bytecode v6
}

