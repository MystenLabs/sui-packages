module 0xa15b738357cedc018069c3ab15989993d3279e2ec01050e9e9d764d06b2f2ce8::vonk {
    struct VONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: VONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VONK>(arg0, 6, b"VONK", b"VONK SUI", b"Introducing $VONK - BONK'S NIGHTMARE! VONK, the disruptor set to flip BONK and shake up the meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_10_21_20_56_51_0a36bf2d2b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

