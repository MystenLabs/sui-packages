module 0x1aaf9179881ad74309b3aa0dc22525b6e0bf99d9ee032fb3ca7019bee90092df::coil {
    struct COIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIL>(arg0, 6, b"Coil", b"Coil For Sui", b"Best dog for world now sui inside coil", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/coil_d322f669fd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

