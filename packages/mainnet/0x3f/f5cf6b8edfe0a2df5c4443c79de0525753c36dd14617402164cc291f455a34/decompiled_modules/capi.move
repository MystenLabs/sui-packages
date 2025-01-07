module 0x3ff5cf6b8edfe0a2df5c4443c79de0525753c36dd14617402164cc291f455a34::capi {
    struct CAPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPI>(arg0, 6, b"CAPI", b"Capitalise AI", b"Create automatic AI trading strategy by typing them in english, go simulate deploy and all for free", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000152671_5dedc7b187.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

