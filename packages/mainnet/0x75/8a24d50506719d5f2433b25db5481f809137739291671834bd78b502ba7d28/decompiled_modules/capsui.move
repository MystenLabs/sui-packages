module 0x758a24d50506719d5f2433b25db5481f809137739291671834bd78b502ba7d28::capsui {
    struct CAPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPSUI>(arg0, 6, b"CAPSUI", b"Captain Sui", b"From now on, the Sui network will have its first and only CAPTAIN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifqj56tbrqnfqn6lkd4zjgrflaupqxpotev77catubir2cqjbdjhy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CAPSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

