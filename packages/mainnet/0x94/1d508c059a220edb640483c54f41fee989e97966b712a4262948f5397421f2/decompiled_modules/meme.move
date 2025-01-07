module 0x941d508c059a220edb640483c54f41fee989e97966b712a4262948f5397421f2::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME>(arg0, 9, b"Web", b"Web", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media-cdn-v2.laodong.vn/storage/newsportal/2024/10/11/1406466/Diddy-2.jpeg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MEME>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<MEME>>(0x2::coin::mint<MEME>(&mut v2, 8181054663000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

