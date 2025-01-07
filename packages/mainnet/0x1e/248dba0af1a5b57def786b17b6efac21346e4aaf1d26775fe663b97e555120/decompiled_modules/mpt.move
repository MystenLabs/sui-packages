module 0x1e248dba0af1a5b57def786b17b6efac21346e4aaf1d26775fe663b97e555120::mpt {
    struct MPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MPT>(arg0, 9, b"PRINCE", b"Prince", b"This is a token description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://amber-hilarious-ostrich-689.mypinata.cloud/files/bafkreidxafmelx4leds5kgqwwxvkapageyq4tf7f74k2nw4nkz4wbgwzqy?X-Algorithm=PINATA1&X-Date=1732118396&X-Expires=315360000&X-Method=GET&X-Signature=6e65413b5b30a0346a20a3e2caa3b39547f17deecaf2ecd0f671b935412e4d24"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MPT>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MPT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MPT>>(v2);
    }

    // decompiled from Move bytecode v6
}

