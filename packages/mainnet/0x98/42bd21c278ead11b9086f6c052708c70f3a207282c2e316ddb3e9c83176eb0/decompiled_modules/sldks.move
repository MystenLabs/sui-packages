module 0x9842bd21c278ead11b9086f6c052708c70f3a207282c2e316ddb3e9c83176eb0::sldks {
    struct SLDKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLDKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLDKS>(arg0, 9, b"SLDKS", b"DKJGKDJKFJ", b"DVMKLDFJKGJFGK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SLDKS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLDKS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLDKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

