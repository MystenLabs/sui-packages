module 0xe372eeeb2abb10a326557f52f2a295f8dd8fd846bbb5fa60f2ba9c9a5cf929b0::est23 {
    struct EST23 has drop {
        dummy_field: bool,
    }

    fun init(arg0: EST23, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EST23>(arg0, 6, b"EST23", b"dfgasd", b"sdas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.artistfirst.in/uploads/1738928141773-upload.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EST23>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EST23>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

