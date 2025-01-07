module 0x5ee2ca8e70f5ceece8c9fde2ea7e6367458fc29d5d2b5cc96d0bf339c7ca3b94::fud {
    struct FUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUD>(arg0, 9, b"FUD", b"FUD AI", x"4c657665726167696e6720414920746f2064657374726f79207370616d20616e6420465544206f6e2054656c656772616d2e0d0a0d0a426f743a20742e6d652f4655444149524f424f540d0a576562736974653a2046554441492e61690d0a446f63733a2066756461692e676974626f6f6b2e696f2f6675642d61690d0a583a20782e636f6d2f46756441694f6666696369616c0d0a54473a20742e6d652f46756441694f6666696369616c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXwTzyFqsVbt5gFDwke8CyxsHtiyRFPB4s9WoALFY5nZ9")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FUD>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

