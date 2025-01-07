module 0x60fa783294be01f5231174b64f1e76baa97a906e42e664cd780cda5a25b026f6::suift {
    struct SUIFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFT>(arg0, 6, b"SUIFT", b"TAYLOR SUIFT", b"A tribute to a great singer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TAYLOR_6daff3dee4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

