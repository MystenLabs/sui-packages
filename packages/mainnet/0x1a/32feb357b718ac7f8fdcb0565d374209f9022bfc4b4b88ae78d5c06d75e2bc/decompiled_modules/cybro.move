module 0x1a32feb357b718ac7f8fdcb0565d374209f9022bfc4b4b88ae78d5c06d75e2bc::cybro {
    struct CYBRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYBRO>(arg0, 9, b"CYBRO", b"CYBRO", b"Cyber Of Coins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cybro.io/_next/static/media/favicon.e67604f4.ico")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CYBRO>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYBRO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CYBRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

