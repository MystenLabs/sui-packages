module 0xa6dfd0d18ca67e77b53333170acacf3b22017fc6e7c2cfd54044a71b630b01a3::boi {
    struct BOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOI>(arg0, 9, b"Boi", b"Boi", b"good boi of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1843685564760907776/uJoGFof7_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

