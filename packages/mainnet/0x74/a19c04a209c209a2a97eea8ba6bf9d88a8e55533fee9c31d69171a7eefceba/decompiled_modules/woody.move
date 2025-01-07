module 0x74a19c04a209c209a2a97eea8ba6bf9d88a8e55533fee9c31d69171a7eefceba::woody {
    struct WOODY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOODY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOODY>(arg0, 9, b"WOODY", b"Woodman", b"Crazy, Funny and wild money token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1816873564395499520/16-Yze-2.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WOODY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOODY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOODY>>(v1);
    }

    // decompiled from Move bytecode v6
}

