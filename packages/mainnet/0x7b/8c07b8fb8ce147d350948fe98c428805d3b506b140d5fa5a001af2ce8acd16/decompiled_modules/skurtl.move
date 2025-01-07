module 0x7b8c07b8fb8ce147d350948fe98c428805d3b506b140d5fa5a001af2ce8acd16::skurtl {
    struct SKURTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKURTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKURTL>(arg0, 9, b"SKURTL", b"Skurtl On Sui", b"A cute and badass turtle shredding its way through SUI https://x.com/SuiSkurtl  https://skurtl.xyz/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SKURTL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKURTL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKURTL>>(v1);
    }

    // decompiled from Move bytecode v6
}

