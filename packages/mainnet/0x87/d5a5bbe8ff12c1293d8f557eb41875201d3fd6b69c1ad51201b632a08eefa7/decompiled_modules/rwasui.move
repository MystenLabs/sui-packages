module 0x87d5a5bbe8ff12c1293d8f557eb41875201d3fd6b69c1ad51201b632a08eefa7::rwasui {
    struct RWASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RWASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RWASUI>(arg0, 9, b"RWASUI", b"RWASUI", b"RWASUI is the Next-Gen RWA Marketplace and Wealth Management Platform, revolutionizing the crypto space through RWA tokenization. Powered by SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1881422942514343936/7MR3uqky_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RWASUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<RWASUI>>(0x2::coin::mint<RWASUI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RWASUI>>(v2);
    }

    // decompiled from Move bytecode v6
}

