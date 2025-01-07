module 0xc9ad3115d28cea77bfad0e67a8f3931ad681f34cbdd46d47f6fa1d60e0a0f68b::uaaa {
    struct UAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: UAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UAAA>(arg0, 6, b"UAAA", b"aaaCHIMP", b"UHHH UHHH aaaaa aaaaa aaaaaaaaaaa!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaaachymp_d90d6c1483.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

