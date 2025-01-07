module 0x928b131e15185e287855beadb7233330e01ea03ff4080d34b55efce2dba2c659::s733733 {
    struct S733733 has drop {
        dummy_field: bool,
    }

    fun init(arg0: S733733, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S733733>(arg0, 6, b"S733733", b"733733", b"733733 = Pepe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/73_909d57c8c9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S733733>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<S733733>>(v1);
    }

    // decompiled from Move bytecode v6
}

