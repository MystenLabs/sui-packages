module 0xe6cc8f60c9330d1b033eae8360f3cdef1ef3135ae1fd6136ae12e564d6365209::nolq {
    struct NOLQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOLQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOLQ>(arg0, 6, b"NOLQ", b"No Liq", b"Hey there there are are are are we ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9155_406f97eb96.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOLQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOLQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

