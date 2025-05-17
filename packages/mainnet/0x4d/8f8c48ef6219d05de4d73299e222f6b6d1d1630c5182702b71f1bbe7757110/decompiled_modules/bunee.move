module 0x4d8f8c48ef6219d05de4d73299e222f6b6d1d1630c5182702b71f1bbe7757110::bunee {
    struct BUNEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNEE>(arg0, 6, b"BUNEE", b"Bunee", x"42756e65652069732061206368696c6c2062756e6e792c204172742062617365642070726f6a656374206272696e67696e672061727420746f207468652053756920426c6f636b636861696e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bunee_logo_5d1211c39b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUNEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

