module 0xef5bde4438b0de489b4460cbed68edfd2fd33f2941e114ece6baf2475aec8730::ssuit {
    struct SSUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSUIT>(arg0, 6, b"SSUIT", b"SUI SUIT", x"5468652073757065726865726f2020616e642068697320616476656e74757265206f6e207468652053554920626c6f636b636861696e0a0a4f6e636520612063656c6562726174656420636f6d70616e696f6e206f662068756d616974792c207468697320535549535549542073746f727920756e726176656c730a66726f6d20746563686e6f6c6f676963616c2072656c6576616e636520746f20736f63696574616c206f626c6976696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_15_18_28_44_c6fbbe59cb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSUIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSUIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

