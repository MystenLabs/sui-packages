module 0xcb630d35e67e640d2d280289c536ece8919066472112ba540ad46b4641576806::trumpx {
    struct TRUMPX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPX>(arg0, 6, b"TRUMPX", b"Trumpverse", b"$TRUMPX is memecoin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241022_051738_375_ea4195ff08.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPX>>(v1);
    }

    // decompiled from Move bytecode v6
}

