module 0x3e9618c4f66c81c0e1308e1bc07c1c770bdf271c4cff8e248da3bb69cbebf25e::puff {
    struct PUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFF>(arg0, 6, b"PUFF", b"Jigglupuff Pokemon", x"5468652073696e67696e6720766f696365206f66205075666620697320746865206265737420616d6f6e6720616c6c20506f6bc3a96d6f6e206f6e2053756920616e642068656c70206d6f7265206368696c6472656e20416672696361", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigfurzdmjtcrxol7ja23a34jqtusmqsmxxagrbokxejsu7zs4cxnm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUFF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

