module 0x24e779d7507f8d1bfe18e3299bbfd7471d9bdbfd5e817de1d6bac23b86e85f14::orbit {
    struct ORBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORBIT>(arg0, 9, b"ORBIT", b"OrbitToken", b"A new token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ORBIT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORBIT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

