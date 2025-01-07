module 0xab183b7645bff9f999fc9c0bf2aca304afe254e8d20dc5467d32d521ae0610e9::doshi {
    struct DOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOSHI>(arg0, 6, b"Doshi", b"DOSHI", b"DOSHI is a memecoin on the Sui network that combines the humorous elements of Dogecoin and Shiba Inu. With a focus on community, DOSHI offers staking, NFTs, and fun events to enhance engagement and provide added value for its holders.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241008_003425_be13303ef5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

