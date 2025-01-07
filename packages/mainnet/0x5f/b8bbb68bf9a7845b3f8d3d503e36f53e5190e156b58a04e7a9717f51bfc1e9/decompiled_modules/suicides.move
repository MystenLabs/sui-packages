module 0x5fb8bbb68bf9a7845b3f8d3d503e36f53e5190e156b58a04e7a9717f51bfc1e9::suicides {
    struct SUICIDES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICIDES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICIDES>(arg0, 6, b"SUICIDES", b"Suicide Shark", b"King Shark is a supervillain appearing in comic books published by DC Comics. Suicides Shark ($Suicides) Now on Sui Network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suicides_66a2a7373b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICIDES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICIDES>>(v1);
    }

    // decompiled from Move bytecode v6
}

