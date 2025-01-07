module 0xf7357e34c642abfb8bea239ac6c62e4e0e36a05eb6aebdce548c94300bc36e6d::fish {
    struct FISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISH>(arg0, 6, b"FISH", b"Touch Fish", b"Touch FISH is inspired by a very famous culture in the East, and we use this meme culture in a broader sense to mean that if you touch fish, something good happens to you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GY_0c_Fkyb_QAIG_4jq_d32eac6a7d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

