module 0x317fa8a325d8cbef2766ddfcd9b2b2cf7646984fe9fc27b1de180bd1f03ede68::pascat {
    struct PASCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PASCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PASCAT>(arg0, 6, b"PASCAT", b"Pasta cat", b"Count meow in", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_174942_53a4270fd6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PASCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PASCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

