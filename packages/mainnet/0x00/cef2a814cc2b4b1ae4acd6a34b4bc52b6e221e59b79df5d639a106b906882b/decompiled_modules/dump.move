module 0xcef2a814cc2b4b1ae4acd6a34b4bc52b6e221e59b79df5d639a106b906882b::dump {
    struct DUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUMP>(arg0, 9, b"DUMP", b"Dump", b"Dump it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/dS2aJVb.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DUMP>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUMP>>(v2, @0x96d9a120058197fce04afcffa264f2f46747881ba78a91beb38f103c60e315ae);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

