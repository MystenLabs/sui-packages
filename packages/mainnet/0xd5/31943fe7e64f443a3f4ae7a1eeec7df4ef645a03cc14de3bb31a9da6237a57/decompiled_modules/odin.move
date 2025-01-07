module 0xd531943fe7e64f443a3f4ae7a1eeec7df4ef645a03cc14de3bb31a9da6237a57::odin {
    struct ODIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ODIN>(arg0, 9, b"ODIN", b"Odin", b"Odin The God, Valhalla Sui Community and Whales LFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1836941259430150144/mufpeS46_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ODIN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ODIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

