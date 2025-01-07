module 0xe5c1952beb3b71129f4a8a28a125c2db9f61cd5bf2ff80a42c0a9ab045d57c63::fisheye {
    struct FISHEYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHEYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHEYE>(arg0, 6, b"FISHEYE", b"Fish Eye", b"Fish Eye on SUI Chain is a project that brings an amazing experience into the blockchain world through the unique perspective of underwater life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xxx_7c46304018.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHEYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHEYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

