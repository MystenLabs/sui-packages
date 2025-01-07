module 0x22c9767170f259f82a9ec31b663a5bc13522ee8913f0aee66cba4f34e17eb114::poi {
    struct POI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POI>(arg0, 6, b"POI", b"POSEIDON", b"kING OF THE SEAS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4956533010413497605_8d1ce16290.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POI>>(v1);
    }

    // decompiled from Move bytecode v6
}

