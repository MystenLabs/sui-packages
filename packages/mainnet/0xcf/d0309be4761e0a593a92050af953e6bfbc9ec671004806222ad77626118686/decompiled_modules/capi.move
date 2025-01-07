module 0xcfd0309be4761e0a593a92050af953e6bfbc9ec671004806222ad77626118686::capi {
    struct CAPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPI>(arg0, 9, b"CAPI", b"Captain Capi", b"Captain Capi to the rescure", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/Qme52teagQUHQnV9eJNA5mKY9aiL8qbHuEjFNQxSHqP1LN"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAPI>>(v1);
        0x2::coin::mint_and_transfer<CAPI>(&mut v2, 1000000000000000000, @0x76e5b88e4f7fd911c8439664804ff9459913fd7b44b2c8bce391d5e0c5073b29, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CAPI>>(v2);
    }

    // decompiled from Move bytecode v6
}

