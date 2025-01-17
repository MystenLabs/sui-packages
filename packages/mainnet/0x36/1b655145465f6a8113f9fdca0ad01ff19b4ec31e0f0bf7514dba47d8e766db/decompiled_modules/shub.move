module 0x361b655145465f6a8113f9fdca0ad01ff19b4ec31e0f0bf7514dba47d8e766db::shub {
    struct SHUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUB>(arg0, 6, b"SHUB", b"SUIHUB", b"#SUIHUB is the first concept of adult photography in the form of NFTs on the #SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ezgif_3_45d3aefc3a_6d4e6b5806.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

