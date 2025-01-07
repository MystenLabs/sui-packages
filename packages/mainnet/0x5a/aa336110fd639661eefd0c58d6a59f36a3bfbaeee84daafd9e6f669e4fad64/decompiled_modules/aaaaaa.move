module 0x5aaa336110fd639661eefd0c58d6a59f36a3bfbaeee84daafd9e6f669e4fad64::aaaaaa {
    struct AAAAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAAAA>(arg0, 6, b"Aaaaaa", b"aaaa", b"aaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_YT_ee39c9a1e5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

