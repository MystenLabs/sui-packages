module 0x4cf37152ff6697ad89bceb5c585e0491a553cfe21648443890c6224f38f91d4a::regon {
    struct REGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: REGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REGON>(arg0, 6, b"REGON", b"Regon Sui", b"Regon Cat is the cheerful mascot representing the spirit of the Revolutionary Generation Online Network (REGON). With soft light blue fur and fluffy cheeks, Regon Cat always shows up with a big, confident grin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih3tfr4fc3nxwea5hpphobj4dfmvunmcagi44iud7aeufz4u4qiq4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REGON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

