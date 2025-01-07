module 0x21541f3f9014ea3878c56131a6f519c299ae597b5388c2ac38b71dd540b7ebff::klaus {
    struct KLAUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLAUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KLAUS>(arg0, 6, b"KLAUS", b"Klaus", b"$KLAUS- Little Fish, Big Dream. Riding the wave into the next generation of meme tokens.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6707b82f254ab7b1e7c91538_1728559151_325a218c67.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KLAUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KLAUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

