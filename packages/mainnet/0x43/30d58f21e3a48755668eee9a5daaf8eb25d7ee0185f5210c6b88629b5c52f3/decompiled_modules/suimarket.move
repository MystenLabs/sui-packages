module 0x4330d58f21e3a48755668eee9a5daaf8eb25d7ee0185f5210c6b88629b5c52f3::suimarket {
    struct SUIMARKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMARKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMARKET>(arg0, 6, b"SUIMARKET", b"Sui Market", b"First prediction market on #Sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_a6e5b18b38.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMARKET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMARKET>>(v1);
    }

    // decompiled from Move bytecode v6
}

