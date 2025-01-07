module 0x756a44d82ea0ea2589214bf1b96164daeba13828c2def788b3a4c0063abe7c97::bibber {
    struct BIBBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIBBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIBBER>(arg0, 6, b"Bibber", b"Bertbibber", x"42696262657220697320746865206d6f73742070726563696f757320636f696e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049180_678e2cea2f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIBBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIBBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

