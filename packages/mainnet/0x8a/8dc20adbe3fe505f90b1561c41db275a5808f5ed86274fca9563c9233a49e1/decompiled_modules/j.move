module 0x8a8dc20adbe3fe505f90b1561c41db275a5808f5ed86274fca9563c9233a49e1::j {
    struct J has drop {
        dummy_field: bool,
    }

    fun init(arg0: J, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<J>(arg0, 6, b"J", b"Joker", b"The only sensible way to live in this world is without rules", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1298817_585fe2139f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<J>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<J>>(v1);
    }

    // decompiled from Move bytecode v6
}

