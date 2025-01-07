module 0x5101d99ff6bafac0d962e330df4028b7b715495863226e050303eb7c892df105::u {
    struct U has drop {
        dummy_field: bool,
    }

    fun init(arg0: U, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<U>(arg0, 6, b"U", b"Unity Software", b"Unity Software (U) Roaring Kitty's next stock pick", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Unity_PFP_6140556a64.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<U>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<U>>(v1);
    }

    // decompiled from Move bytecode v6
}

