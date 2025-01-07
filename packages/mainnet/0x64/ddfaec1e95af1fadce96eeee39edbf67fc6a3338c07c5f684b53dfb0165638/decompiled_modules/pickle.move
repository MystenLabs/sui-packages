module 0x64ddfaec1e95af1fadce96eeee39edbf67fc6a3338c07c5f684b53dfb0165638::pickle {
    struct PICKLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PICKLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PICKLE>(arg0, 6, b"Pickle", b"Pickle of Sui", x"54686520667269656e646c69657374207069636b6c65206f66205375692e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pickle_73d7171db6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PICKLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PICKLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

