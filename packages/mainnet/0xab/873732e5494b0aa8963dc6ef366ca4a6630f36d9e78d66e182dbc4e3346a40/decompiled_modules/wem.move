module 0xab873732e5494b0aa8963dc6ef366ca4a6630f36d9e78d66e182dbc4e3346a40::wem {
    struct WEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEM>(arg0, 6, b"WEM", b"the cat in a world of drugs", b"$WEM - the cat in a world of drugs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241226_084059_402_6244ad8089.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

