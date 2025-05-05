module 0xf27b267595ee891f6405a5de1a6300ef8bd08bcdac17590df9fb32d69e808e14::moza {
    struct MOZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOZA>(arg0, 9, b"MOZA", b"MOZZARELLO", b"STRECH YOUR WALLET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOZA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOZA>>(v2, @0xde4fd02832c75f709a14acf7d8cf10102f2f3d0eeaa90a91ebb54d7c396ae7c5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

