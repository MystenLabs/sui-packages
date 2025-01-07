module 0xbcf310cb6c8fe0959ac8f3856d7cc8c1547bccffb793cf35e5ddcc59a2d80c67::bluey {
    struct BLUEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEY>(arg0, 9, b"BLUEY", b"BLUEY", b"Bluey on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/bafkreidyuzd46zdupemxre4yo2zbt4ivtiygty4ipd6oushtgls5obpp4q"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUEY>>(v1);
        0x2::coin::mint_and_transfer<BLUEY>(&mut v2, 1000000000000000000, @0x9d692dcb408bc26cbe493bbba294cf5adea689ff550b08d8630600c3358044a9, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BLUEY>>(v2);
    }

    // decompiled from Move bytecode v6
}

