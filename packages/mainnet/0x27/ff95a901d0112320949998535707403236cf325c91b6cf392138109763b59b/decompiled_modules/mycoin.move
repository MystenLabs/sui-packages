module 0x27ff95a901d0112320949998535707403236cf325c91b6cf392138109763b59b::mycoin {
    struct MYCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYCOIN>(arg0, 5, b"USDT ", b"USDT ", b"my coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibdmzy6umk5drqgmaa7fti73thnxiy5c6hxcqqc4g72yfldv42weu")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MYCOIN>(&mut v2, 75120000100000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYCOIN>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

