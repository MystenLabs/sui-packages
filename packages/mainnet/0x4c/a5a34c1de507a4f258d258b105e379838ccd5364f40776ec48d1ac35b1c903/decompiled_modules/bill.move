module 0x4ca5a34c1de507a4f258d258b105e379838ccd5364f40776ec48d1ac35b1c903::bill {
    struct BILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILL>(arg0, 6, b"Bill", b"Billion dollar DOG", b"Auction starting at $1B", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_A_cute_small_anthropomorphic_light_blue_Labra_0_e0a28ade22.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

