module 0x8fafa6881c3c65f727c12ad0379c517cf9fc6d56bfaf7a8c949129fc4cfdcb23::apeconomy {
    struct APECONOMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: APECONOMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APECONOMY>(arg0, 6, b"Apeconomy", b"Apeconomy Business", b"Strong Apeconomy, Apes Strong Together than ever. Chart go up.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifjg2uh7fazvopalx5myl2zuojshgsouc7fl2jj5gd6pp7cw6wngu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APECONOMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<APECONOMY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

