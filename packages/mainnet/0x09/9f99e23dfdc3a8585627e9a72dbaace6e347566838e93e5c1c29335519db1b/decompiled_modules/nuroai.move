module 0x99f99e23dfdc3a8585627e9a72dbaace6e347566838e93e5c1c29335519db1b::nuroai {
    struct NUROAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUROAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUROAI>(arg0, 8, b"NuroAI", b"NuroAI", x"506f77657266756c2047505520636f6d7075746520736f6c7574696f6e73206f6e2d64656d616e640a0a57652070726f76696465207365637572652c20636f73742d6566666563746976652061636365737320746f20656e746572707269736520677261646520475055732061726f756e642074686520776f726c642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/5116cbc1-ea54-4d81-b509-20264f796044.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NUROAI>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUROAI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUROAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

