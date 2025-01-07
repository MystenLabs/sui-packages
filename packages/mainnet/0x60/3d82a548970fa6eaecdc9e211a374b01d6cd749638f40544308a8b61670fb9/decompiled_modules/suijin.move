module 0x603d82a548970fa6eaecdc9e211a374b01d6cd749638f40544308a8b61670fb9::suijin {
    struct SUIJIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJIN>(arg0, 6, b"SUIJIN", b"Suijin", b"When Goku goes Super Saiyan Blue with the power of SUIJIN in his hands, nothing can stop him!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000238689_7419667613.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

