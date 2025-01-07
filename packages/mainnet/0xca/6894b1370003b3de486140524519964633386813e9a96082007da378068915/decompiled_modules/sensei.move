module 0xca6894b1370003b3de486140524519964633386813e9a96082007da378068915::sensei {
    struct SENSEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENSEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENSEI>(arg0, 9, b"SENSEI", b"Sensei", b"Sui Sensei", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1827719960266670080/G3-ImjWG_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SENSEI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENSEI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENSEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

