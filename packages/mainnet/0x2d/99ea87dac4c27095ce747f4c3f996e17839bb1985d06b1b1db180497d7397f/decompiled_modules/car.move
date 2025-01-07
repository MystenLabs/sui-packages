module 0x2d99ea87dac4c27095ce747f4c3f996e17839bb1985d06b1b1db180497d7397f::car {
    struct CAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAR>(arg0, 6, b"CAR", b"Cat with crab", b"i loev this car so much", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_15_214606_59fd3cb1e5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

