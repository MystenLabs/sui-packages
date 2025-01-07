module 0xd5f122209e8f70178065d9307cf737a9f744e701cf9b2d766ff104becbbd9b40::soapy {
    struct SOAPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOAPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOAPY>(arg0, 6, b"SOAPY", b"Lord Soap", b"Wash jeets away make profits today  The cleanest coin on SUI Rule #1: dont drop the soap  get the cleanest bag in the game  Join VC - Dev is doxed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_26_at_3_22_55a_PM_3ea2dc0a00.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOAPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOAPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

