module 0x2dc18d58a40509924c9493fb4903d8b607ca27e88674308b3330a1ae51197eaa::did {
    struct DID has drop {
        dummy_field: bool,
    }

    fun init(arg0: DID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DID>(arg0, 6, b"DID", b"DAVE IS DEV", b"Let's go send to Bond at few minutes. Will pay dex and moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004560_3df6979e37.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DID>>(v1);
    }

    // decompiled from Move bytecode v6
}

