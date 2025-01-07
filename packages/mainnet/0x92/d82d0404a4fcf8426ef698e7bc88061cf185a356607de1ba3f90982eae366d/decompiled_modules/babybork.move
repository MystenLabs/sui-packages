module 0x92d82d0404a4fcf8426ef698e7bc88061cf185a356607de1ba3f90982eae366d::babybork {
    struct BABYBORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYBORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYBORK>(arg0, 6, b"BABYBORK", b"Baby Bork", b"Introducing Baby Bork The New Baby Is In Town", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/black_box_306edab7e5_e983c725f4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYBORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYBORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

