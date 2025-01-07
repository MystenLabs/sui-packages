module 0xa369ab65b67c2eda28670c90c73076a95deb802e791111f364fc6d699aeff9b3::doshi {
    struct DOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOSHI>(arg0, 6, b"DOSHI", b"Doshi sui", b"DOSHI is a memecoin on the Sui network that combines the humorous elements of Dogecoin and Shiba Inu. With a focus on community, DOSHI offers staking, NFTs, and fun events to enhance engagement and provide added value for its holders", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_13_13_06_ea8de2b1ed.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

