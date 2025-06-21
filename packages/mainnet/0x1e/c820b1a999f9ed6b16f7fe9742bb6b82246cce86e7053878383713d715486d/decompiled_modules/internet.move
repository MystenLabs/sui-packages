module 0x1ec820b1a999f9ed6b16f7fe9742bb6b82246cce86e7053878383713d715486d::internet {
    struct INTERNET has drop {
        dummy_field: bool,
    }

    fun init(arg0: INTERNET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INTERNET>(arg0, 8, b"INTERNET", b"INTERNET COIN", b"INTERNET  on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/ffa4805e-2163-4f90-8bad-5eaa5b147433.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<INTERNET>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INTERNET>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INTERNET>>(v1);
    }

    // decompiled from Move bytecode v6
}

