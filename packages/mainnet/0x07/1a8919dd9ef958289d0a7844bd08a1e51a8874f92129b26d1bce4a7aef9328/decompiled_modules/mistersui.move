module 0x71a8919dd9ef958289d0a7844bd08a1e51a8874f92129b26d1bce4a7aef9328::mistersui {
    struct MISTERSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MISTERSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MISTERSUI>(arg0, 6, b"MISTERSUI", b"Mr. Sui", b"Token representing a community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dtf_b9c5403f38.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MISTERSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MISTERSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

