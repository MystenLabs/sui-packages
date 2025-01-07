module 0x76f1b402a68fee6d09709052649ee9fbfaf112987806e7d9b928b8a364fd6e99::os {
    struct OS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OS>(arg0, 6, b"OS", b"SuiOS", b"SuiOS is about to drop and we're this close to revolutionizing the future of DEX trading on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000038982_5d81bf4b79.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OS>>(v1);
    }

    // decompiled from Move bytecode v6
}

