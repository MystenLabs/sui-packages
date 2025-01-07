module 0x43f47b54e19d2f279d78ebf5ed77094e4341d524b92b2cdfa525a2b872826cc::PEBO {
    struct PEBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEBO>(arg0, 9, b"PEBO", b"SUI PEBO", b"PEBO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1752530442140438528/GuYQNl_D_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEBO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PEBO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

