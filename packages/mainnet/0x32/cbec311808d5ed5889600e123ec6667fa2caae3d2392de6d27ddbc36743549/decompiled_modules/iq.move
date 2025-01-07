module 0x32cbec311808d5ed5889600e123ec6667fa2caae3d2392de6d27ddbc36743549::iq {
    struct IQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: IQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IQ>(arg0, 6, b"IQ", b"IQ Token", b"Legendary IQ token, launched by Alex Svanevick from Nansen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/banner_9d496502f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

