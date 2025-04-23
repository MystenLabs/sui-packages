module 0xfdc65e29e7602293b739147dab71291a49503499321e9268748522b182bb9763::stake {
    struct STAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAKE>(arg0, 6, b"STAKE", b"STAKECOIN on BAGS", b"It's not steak, it's STAKE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiggbotxmksmdghbdhqpy5tmslwxpm6sjcvxp44uxezfzqwzee2o5y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STAKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

