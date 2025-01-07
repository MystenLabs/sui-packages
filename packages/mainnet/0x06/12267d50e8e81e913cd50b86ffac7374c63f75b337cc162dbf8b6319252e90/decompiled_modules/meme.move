module 0x612267d50e8e81e913cd50b86ffac7374c63f75b337cc162dbf8b6319252e90::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME>(arg0, 9, b"MEME", b"SuiMeme", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx2_aKWnhGPnacvcRJ8TXQpJMAXcYv4q-3SA&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEME>(&mut v2, 4000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

