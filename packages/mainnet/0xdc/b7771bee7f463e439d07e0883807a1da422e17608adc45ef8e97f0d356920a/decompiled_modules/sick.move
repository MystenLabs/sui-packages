module 0xdcb7771bee7f463e439d07e0883807a1da422e17608adc45ef8e97f0d356920a::sick {
    struct SICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SICK>(arg0, 6, b"SICK", b"Sui Duck", b"Sui duck is just as unstoppable as Sui itself.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiakisc6cakst7qjjjcgqsm4b6l7bixyet7eucauvjbd6g2yz2up3i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SICK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

