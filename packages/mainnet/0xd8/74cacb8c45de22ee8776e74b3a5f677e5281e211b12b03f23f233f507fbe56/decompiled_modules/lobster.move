module 0xd874cacb8c45de22ee8776e74b3a5f677e5281e211b12b03f23f233f507fbe56::lobster {
    struct LOBSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOBSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOBSTER>(arg0, 6, b"Lobster", b"LOB", b"https://x.com/1goonrich/status/1845070516186452192", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pngegg_cc8bf24418.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOBSTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOBSTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

