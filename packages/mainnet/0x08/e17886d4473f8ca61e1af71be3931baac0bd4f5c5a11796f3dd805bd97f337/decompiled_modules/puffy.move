module 0x8e17886d4473f8ca61e1af71be3931baac0bd4f5c5a11796f3dd805bd97f337::puffy {
    struct PUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFY>(arg0, 9, b"PUFFY", b"Puffy Club", b"Puffy Club is a fun, community-focused token on the Sui blockchain, offering rewards and exclusive experiences in a friendly ecosystem. It's perfect for those who enjoy lighthearted engagement and digital connections.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1307867897339895808/WBkGkZwH.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUFFY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

