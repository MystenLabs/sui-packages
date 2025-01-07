module 0x79cb4e49cbdcfe1c90cc2669eaa5ea4b25973d0c997e8b40b8bd43742d623115::nogay {
    struct NOGAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOGAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOGAY>(arg0, 9, b"NOGAY", b"BUY IF YOU ARE NOT GAY", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NOGAY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOGAY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOGAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

