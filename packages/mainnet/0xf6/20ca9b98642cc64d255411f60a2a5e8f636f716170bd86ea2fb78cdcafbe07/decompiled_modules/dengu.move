module 0xf620ca9b98642cc64d255411f60a2a5e8f636f716170bd86ea2fb78cdcafbe07::dengu {
    struct DENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DENGU>(arg0, 9, b"DENGU", b"Sui Dengu", b"The cutes big eyed baby hippo, Dengu!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmPVzh7L4cPDMSQNaQuCmVXRyaRghpgEC5cZ6hm5tjnWHS?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DENGU>(&mut v2, 2000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DENGU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DENGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

