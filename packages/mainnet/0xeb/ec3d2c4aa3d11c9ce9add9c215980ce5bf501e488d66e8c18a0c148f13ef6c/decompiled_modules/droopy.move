module 0xebec3d2c4aa3d11c9ce9add9c215980ce5bf501e488d66e8c18a0c148f13ef6c::droopy {
    struct DROOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROOPY>(arg0, 6, b"DROOPY", b"Sui Droopy", b"Droopy is a legendary dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016466_d6c638a665.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROOPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DROOPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

