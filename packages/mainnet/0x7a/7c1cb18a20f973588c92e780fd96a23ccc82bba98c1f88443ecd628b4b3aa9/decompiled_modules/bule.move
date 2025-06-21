module 0x7a7c1cb18a20f973588c92e780fd96a23ccc82bba98c1f88443ecd628b4b3aa9::bule {
    struct BULE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULE>(arg0, 6, b"bule", b"bule", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/18b4e18a-782e-41ce-a5b2-68b33693141e.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BULE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULE>>(v1);
    }

    // decompiled from Move bytecode v6
}

