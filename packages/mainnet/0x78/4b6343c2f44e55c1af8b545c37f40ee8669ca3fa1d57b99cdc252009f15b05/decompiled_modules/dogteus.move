module 0x784b6343c2f44e55c1af8b545c37f40ee8669ca3fa1d57b99cdc252009f15b05::dogteus {
    struct DOGTEUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGTEUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGTEUS>(arg0, 8, b"DOGTEUS", b"Dogteus Maximus", b"...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/CXAtTTTyrHYt1B7pc8CJThygsTLWszd9ASffCE1Npump.png?size=xl&key=a3f2c2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOGTEUS>(&mut v2, 20000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGTEUS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGTEUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

