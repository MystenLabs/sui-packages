module 0x4d8248f14e1545a29f15d3f29b43475424cefe8004f04adbef2be8aad07e7f4b::frgcoin {
    struct FRGCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRGCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRGCOIN>(arg0, 9, b"FRGCOIN", b"Frogocoin", b"This is a coin created by a group of active community and they are ready to make history", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FRGCOIN>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRGCOIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRGCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

