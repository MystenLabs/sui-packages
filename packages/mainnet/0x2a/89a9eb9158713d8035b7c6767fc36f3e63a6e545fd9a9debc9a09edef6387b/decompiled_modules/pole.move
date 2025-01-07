module 0x2a89a9eb9158713d8035b7c6767fc36f3e63a6e545fd9a9debc9a09edef6387b::pole {
    struct POLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLE>(arg0, 6, b"POLE", b"Pole Sui", b"Hi, I'm $POLE embodying the chill vibes in his icy home, bringing joy and laughter wherever he goes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241009_231700_edb800813b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

