module 0x2c1ed3913e589b6593baf995b9ea09a052ac289acefc04a2b28a28df67a57347::shaolinn {
    struct SHAOLINN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAOLINN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAOLINN>(arg0, 6, b"Shaolinn", b"shaolin", b"shaoli", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicnjr5l7zmztwqlpl7jvxq52eqo3vtva6hsvl43wj7ifuy3vctcy4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAOLINN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHAOLINN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

