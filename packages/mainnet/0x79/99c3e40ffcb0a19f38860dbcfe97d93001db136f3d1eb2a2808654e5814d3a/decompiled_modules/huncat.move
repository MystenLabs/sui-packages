module 0x7999c3e40ffcb0a19f38860dbcfe97d93001db136f3d1eb2a2808654e5814d3a::huncat {
    struct HUNCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUNCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUNCAT>(arg0, 6, b"HunCat", b"HuhCat", b"Hun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000039468_4815ccb7d9.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUNCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUNCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

