module 0x51e52ee86985b28e5b92a5650b688775b80b8323e4db8fea59b51d4015f9a102::kekkk {
    struct KEKKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEKKK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEKKK>(arg0, 6, b"KEKKK", b"kek", b"32", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ezgif_1_f326e53c17_bec1fdb036.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEKKK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEKKK>>(v1);
    }

    // decompiled from Move bytecode v6
}

