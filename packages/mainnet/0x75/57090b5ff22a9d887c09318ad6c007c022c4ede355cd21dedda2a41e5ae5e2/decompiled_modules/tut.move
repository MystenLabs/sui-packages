module 0x7557090b5ff22a9d887c09318ad6c007c022c4ede355cd21dedda2a41e5ae5e2::tut {
    struct TUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUT>(arg0, 6, b"Tut", b"Pututu", b"i'm tut, u're tut, we're tut", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pututu_25109b9103.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

