module 0x3a862b4db9a03b9b3cb1c4fbedb4165f5f29dfbd20038ed43eaf0ebf0c4271e5::mocksui {
    struct MOCKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOCKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCKSUI>(arg0, 9, b"MOCKSUI", b"mockSUI", b"mockSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"mockSUI")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOCKSUI>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCKSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOCKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

