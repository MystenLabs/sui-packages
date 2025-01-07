module 0xe3d91d9b43a3b2d429819d3e152f54521ca2476e8016bf25cf0b3ebfdfb3743::taxi {
    struct TAXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAXI>(arg0, 6, b"TAXI", b"SUI TAXI", b"$TAXI Take you to moon !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/500x500_6d60213f8f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAXI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAXI>>(v1);
    }

    // decompiled from Move bytecode v6
}

