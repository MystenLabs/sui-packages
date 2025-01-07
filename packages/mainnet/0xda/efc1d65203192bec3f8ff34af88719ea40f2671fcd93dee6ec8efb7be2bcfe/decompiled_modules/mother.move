module 0xdaefc1d65203192bec3f8ff34af88719ea40f2671fcd93dee6ec8efb7be2bcfe::mother {
    struct MOTHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOTHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOTHER>(arg0, 9, b"MOTHER", b"MOTHER", b"Mother is here to provide", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1796011977065521152/q-FIwPVP.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOTHER>(&mut v2, 220000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOTHER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOTHER>>(v1);
    }

    // decompiled from Move bytecode v6
}

