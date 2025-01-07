module 0xf0e27e91c57c8fc43ec4a9de5d98982db47f35e1823b4bd1591a0134d5c6fb60::sewey {
    struct SEWEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEWEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEWEY>(arg0, 6, b"SEWEY", b"Sewey on Sui", x"7768656e207370656564206d6565747320737569203d2073657765790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sewey_on_Sui2_3c5c35f39a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEWEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEWEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

