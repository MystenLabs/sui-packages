module 0xc9ee1c51d2c9d70a0df48f4f31756a688738cbe2720cb827e5aac2ac4c4fa55e::asd {
    struct ASD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASD>(arg0, 9, b"ASD", b"ASDF", b"ADFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://files.oaiusercontent.com/file-Mm9GLz83hzfPdpVCd5r9CDP4?se=2024-04-27T02%3A50%3A34Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D31536000%2C%20immutable&rscd=attachment%3B%20filename%3D44fd42d8-2880-48c4-8da7-db71efb2eb98.webp&sig=VWlTMsClpp93v7DzqYjGifO57/XrWZDVF2H7XPhFi9Y%3D")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ASD>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASD>>(v1);
    }

    // decompiled from Move bytecode v6
}

