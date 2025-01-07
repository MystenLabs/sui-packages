module 0xc17c5ab8ca8c78ada4923307faa3b7440399b262e62392b24dc56ef24ca6563::walrus {
    struct WALRUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALRUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALRUS>(arg0, 6, b"Walrus", b"walrus", b"Liberate your platform and content", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asdasdasdasdasdasdasdasd_0a7703c0e8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALRUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALRUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

