module 0x9464c55abd356eedf0613ca8a5155286bd423cc65fdca466eab6a402cc12c2a9::vtl {
    struct VTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: VTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VTL>(arg0, 6, b"VTL", b"Vitalment coin", b"Welcome to Vitalment  Mental health affects us all. 1 in 5 struggle, and were here to change that while helping the other 4 stay well.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000076454_2db5ee9c74.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VTL>>(v1);
    }

    // decompiled from Move bytecode v6
}

