module 0xb46b22da9c0e0f2a69b920c9dc488d3d4ab0475d89814df815a33a8638e4c008::win98ai {
    struct WIN98AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIN98AI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIN98AI>(arg0, 9, b"WIN98AI", x"57494e39382d4149e280a443304d", b"Official Microsoft coin on SUI. Get your airdrop today !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSnMTR3fBoc-pAJYs4vPs8m7_haJFcLfvl6w&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WIN98AI>(&mut v2, 9800000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIN98AI>>(v2, @0xceff4dbae145e603cb6701b56f895e28048da28982866b24cbd5bcc40306046);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIN98AI>>(v1);
    }

    // decompiled from Move bytecode v6
}

