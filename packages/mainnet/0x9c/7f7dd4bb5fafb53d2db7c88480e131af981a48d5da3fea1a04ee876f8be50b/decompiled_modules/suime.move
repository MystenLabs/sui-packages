module 0x9c7f7dd4bb5fafb53d2db7c88480e131af981a48d5da3fea1a04ee876f8be50b::suime {
    struct SUIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIME>(arg0, 5, b"SUIME", b"Sui meme", b"An experiment for the people ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgflip.com/7eokfv.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIME>(&mut v2, 9900000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIME>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

