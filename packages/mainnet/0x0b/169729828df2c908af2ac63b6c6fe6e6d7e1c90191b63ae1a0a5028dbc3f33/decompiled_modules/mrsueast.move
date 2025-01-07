module 0xb169729828df2c908af2ac63b6c6fe6e6d7e1c90191b63ae1a0a5028dbc3f33::mrsueast {
    struct MRSUEAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRSUEAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRSUEAST>(arg0, 6, b"MRSUEAST", b"MrSueast", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/994592419705274369/RLplF55e_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MRSUEAST>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRSUEAST>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRSUEAST>>(v1);
    }

    // decompiled from Move bytecode v6
}

