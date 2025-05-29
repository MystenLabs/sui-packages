module 0xf31efdfca4eb8fa6bda40c1ed44e5366a1a4f4109c8cdc37b42a4b1f0e21e187::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 1, b"TRUMP", b"Trump Official", b"Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/staging/tokens/79a9274d-ef1e-4153-afa0-a56d9b2790a2.webp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRUMP>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

