module 0x122bd07ed8a1b33a91203df778a66e6ca66d6b0d12d5049e3965ff51fea615ba::seacat {
    struct SEACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEACAT>(arg0, 6, b"SEACAT", b"SEA CAT", b"Together on a journey into the vast expanse of the Sui Ocean where legends and mysteries wait to unraveled.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_0ccdcc23d2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

