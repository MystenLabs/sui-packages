module 0x94c68d88082f12af832a238ad614033ebb9886965e102a5ae951554c66173e0c::notoken {
    struct NOTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTOKEN>(arg0, 6, b"NoToken", b"NO TOKEN", b"There is no token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B_18eaa31b42.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

