module 0x4f5c2fc84fd1d15706a389069d4ce455a87f29aeeb4671dad474b3f4237cbfba::wawo {
    struct WAWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAWO>(arg0, 9, b"Wawo", b"Wawocado", b"Fresh, fun and flourishing. https://x.com/Wawocado", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1837034953449644032/ZDjdiPL0_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WAWO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAWO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAWO>>(v1);
    }

    // decompiled from Move bytecode v6
}

