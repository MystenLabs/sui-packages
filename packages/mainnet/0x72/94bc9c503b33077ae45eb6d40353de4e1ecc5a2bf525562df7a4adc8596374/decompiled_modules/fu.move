module 0x7294bc9c503b33077ae45eb6d40353de4e1ecc5a2bf525562df7a4adc8596374::fu {
    struct FU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FU>(arg0, 6, b"FU", b"SUIFU", b"In a vibrant digital landscape where the realms of crypto and culture collide, Sui Fu emerges as a unique memecoin project, bringing to life the legendary story of a kung fu turtle. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_18_23_09_60613e40be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FU>>(v1);
    }

    // decompiled from Move bytecode v6
}

