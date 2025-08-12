module 0xbd8146f3b2efdc0c1622b6958e9547a908ecb9cb41ee0c74743d796949301889::sala {
    struct SALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALA>(arg0, 6, b"SALA", b"Suilamander", b"The Meme. The Myth. The Salamander", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeichxkoqxa4ctmmshea7czoi6m6wg2sreykzarffdr5ijd45tzloqa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SALA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

