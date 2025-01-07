module 0x1c1c4b2848f8fae4db16fe8019f18b465f577836b87843dab2ebbec932f9d864::zuo {
    struct ZUO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUO>(arg0, 6, b"ZUO", b"Sui Zuo", b"$ZUO the roundest boi in town", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002676_58f495e72d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZUO>>(v1);
    }

    // decompiled from Move bytecode v6
}

