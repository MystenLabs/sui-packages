module 0x369b8a444cfc94477cdc5142972f719ad47dc71a742a489a08d20a455a2acdf2::epic {
    struct EPIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: EPIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EPIC>(arg0, 9, b"EPIC", b"Epic Aura", b"https://x.com/i/communities/1957404261806997959", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EPIC>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EPIC>>(v2, @0x79a156b00c8ffe62ad28b07bdf5b7bcd6885f6056e7069cf2f55b8e0c468b273);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EPIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

