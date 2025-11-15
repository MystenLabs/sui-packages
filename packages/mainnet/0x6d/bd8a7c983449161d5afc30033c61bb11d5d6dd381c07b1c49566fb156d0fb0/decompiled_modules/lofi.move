module 0x6dbd8a7c983449161d5afc30033c61bb11d5d6dd381c07b1c49566fb156d0fb0::lofi {
    struct LOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOFI>(arg0, 9, b"LOFI", b"LOFI", b"LOFI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmT8YmiD6hZnrY7RwpPCv7QefkqugdabnBfkLsFYcCqKXN")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LOFI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOFI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

