module 0xdb000c96c99391d608cbc37c3e88029d975c83e3c5be28e06161839469d4f8ab::sealy {
    struct SEALY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEALY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEALY>(arg0, 9, b"SEALY", b"Sealy", b"a cute little seal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/4zrWJVoPFfVrSs6Bt7YDm5Lbwt86FeHZUJJ8p9GXpump.png?size=xl&key=b0cb87")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SEALY>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEALY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEALY>>(v1);
    }

    // decompiled from Move bytecode v6
}

