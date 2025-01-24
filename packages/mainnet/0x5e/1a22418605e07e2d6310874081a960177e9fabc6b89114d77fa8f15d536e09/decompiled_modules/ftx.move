module 0x5e1a22418605e07e2d6310874081a960177e9fabc6b89114d77fa8f15d536e09::ftx {
    struct FTX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FTX>(arg0, 9, b"FTX", b"FTX Coin", b"Born from the ashes of FTXs collapse, $FTX is the memecoin that roasts the wreckage. A tribute to lessons learned and the chaos left behind by SBFs fall.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmaVCkVTsdr4mn6LDQCpaetBMyYwMs1enTtK4rAWpsWNP6")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FTX>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FTX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FTX>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

