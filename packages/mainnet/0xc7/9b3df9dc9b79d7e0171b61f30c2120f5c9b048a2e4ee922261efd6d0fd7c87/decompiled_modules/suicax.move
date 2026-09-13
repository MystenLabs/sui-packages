module 0xc79b3df9dc9b79d7e0171b61f30c2120f5c9b048a2e4ee922261efd6d0fd7c87::suicax {
    struct SUICAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAX>(arg0, 9, b"SUICAX", b"SUICAX ", b"SUICAX  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://gateway.pinata.cloud/ipfs/QmepVAVxZusWaKA7Ppc2KkCwyxDKmhcKt2iVJG3LCgfGvd"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICAX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

