module 0xe25d068f59386bda347344f27b717bf6e45a1ede9cef76d1f84fc7af3b8fd94b::meyo {
    struct MEYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEYO>(arg0, 6, b"MEYO", b"Meyo", b"while youre out and about searching for your next play, dont get meyo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055095_2901d2907c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEYO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEYO>>(v1);
    }

    // decompiled from Move bytecode v6
}

