module 0xbe5bce8c67e235e2ae761bc4fb3b55af04db8bfc7220df96fbf6967db6e1db3f::huhcat {
    struct HUHCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUHCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUHCAT>(arg0, 6, b"HUHCAT", b"HUH CAT", b"HUH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/64bf1330_c434_4ebb_9046_86f33ff1b020_87c9407df6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUHCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUHCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

