module 0x6ccfbb95cbdc11a5a4401419cc6e8708ba9159b9516b7240f771a0de9fd5a4df::frag {
    struct FRAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRAG>(arg0, 8, b"FRAG", b"Fragmetric", b"Liquid (Re)staking on Solana | Stake twice, Earn more.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/2ae96a7a-cad8-4c42-88b7-0502464812fe.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FRAG>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRAG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

