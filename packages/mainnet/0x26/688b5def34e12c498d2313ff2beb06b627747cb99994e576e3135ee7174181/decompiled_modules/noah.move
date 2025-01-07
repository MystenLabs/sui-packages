module 0x26688b5def34e12c498d2313ff2beb06b627747cb99994e576e3135ee7174181::noah {
    struct NOAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOAH>(arg0, 6, b"NOAH", b"NOAH Sui", b"The only one who will save us all is Noah!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2002_077ad3d2ba.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

