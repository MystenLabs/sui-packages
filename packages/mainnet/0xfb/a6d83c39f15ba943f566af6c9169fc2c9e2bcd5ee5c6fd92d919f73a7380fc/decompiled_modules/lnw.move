module 0xfba6d83c39f15ba943f566af6c9169fc2c9e2bcd5ee5c6fd92d919f73a7380fc::lnw {
    struct LNW has drop {
        dummy_field: bool,
    }

    fun init(arg0: LNW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LNW>(arg0, 6, b"LNW", b"Lauchnow", b"SUI 100$", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OK_MAN_592809b127.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LNW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LNW>>(v1);
    }

    // decompiled from Move bytecode v6
}

