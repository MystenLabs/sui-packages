module 0xef0fd1012493993f9c8fa89ddb623aec0b767183714f0f4238587f064ace137a::cloes {
    struct CLOES has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOES>(arg0, 6, b"CLOES", b"Close Eyed Seals", b"Sometimes you just gotta dive in blind and hope for the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_153431_ad4f442625.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLOES>>(v1);
    }

    // decompiled from Move bytecode v6
}

