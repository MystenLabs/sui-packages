module 0xbdfc14db99c452e0128115caa3bbbfe8d257c497f37d1e604d4699bb2ab8f754::brsrk {
    struct BRSRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRSRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRSRK>(arg0, 6, b"BRSRK", b"berserk", b"Just a berserk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidtjztwyxg4zwtv3v7hkum73vcelettrl5odcimpawbfolr7tmx5a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRSRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BRSRK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

