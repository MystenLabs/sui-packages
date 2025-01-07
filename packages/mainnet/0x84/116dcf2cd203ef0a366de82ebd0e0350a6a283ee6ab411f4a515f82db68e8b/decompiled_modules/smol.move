module 0x84116dcf2cd203ef0a366de82ebd0e0350a6a283ee6ab411f4a515f82db68e8b::smol {
    struct SMOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOL>(arg0, 6, b"Smol", b"Smol Cat", b"Smol cat will dominate the sui chads", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0564_74da2dacb6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

