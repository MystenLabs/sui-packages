module 0x769a9a62651f9c8d3c2d77d5be7345b31bb340ae8c5216be170eb188345fce5::mort {
    struct MORT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORT>(arg0, 6, b"MORT", b"Sui Mort", b"Beauty is overrated . Embrace your mort-ality! The memecoin for the misfits. Be who you are", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013605_e036337724.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MORT>>(v1);
    }

    // decompiled from Move bytecode v6
}

