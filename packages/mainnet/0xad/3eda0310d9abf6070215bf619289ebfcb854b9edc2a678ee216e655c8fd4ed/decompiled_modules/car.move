module 0xad3eda0310d9abf6070215bf619289ebfcb854b9edc2a678ee216e655c8fd4ed::car {
    struct CAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAR>(arg0, 9, b"CAR", b"CARBON", b"CARBON is a decentralized cryptocurrency designed for sustainability and environmental impact mitigation. Built on a proof-of-stake consensus mechanism, it aims to minimize energy consumption while promoting eco-friendly practices. With a focus on transparency and community governance, CARBON strives to contribute to a greener future for the blockchain industry.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pin.it/3N78xzI")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CAR>(&mut v2, 333000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

