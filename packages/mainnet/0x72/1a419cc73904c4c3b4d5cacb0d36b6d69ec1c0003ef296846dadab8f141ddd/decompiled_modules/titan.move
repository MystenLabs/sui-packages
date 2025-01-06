module 0x721a419cc73904c4c3b4d5cacb0d36b6d69ec1c0003ef296846dadab8f141ddd::titan {
    struct TITAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITAN>(arg0, 6, b"Titan", b"Titan of Sui", b"THE TITANS OF SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0648_56d6cc6b65.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TITAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

