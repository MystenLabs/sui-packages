module 0x8e2f8b91ceb9d9afc843678697fac84eb5d8a55b4299aea001905d1eab1013ea::siuuuuu {
    struct SIUUUUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIUUUUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIUUUUU>(arg0, 9, b"SIUUUUU", b"SIUUUUU", b"SIUUUUU is on SUI Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/d2tByWV/flat-750x-075-f-pad-750x1000-f8f8f8-u1-modified.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SIUUUUU>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIUUUUU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIUUUUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

