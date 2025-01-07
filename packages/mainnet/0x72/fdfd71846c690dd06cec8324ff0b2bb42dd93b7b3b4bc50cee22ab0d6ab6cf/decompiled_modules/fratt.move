module 0x72fdfd71846c690dd06cec8324ff0b2bb42dd93b7b3b4bc50cee22ab0d6ab6cf::fratt {
    struct FRATT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRATT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRATT>(arg0, 2, b"FRATT", b"FroggnRatt", b"Meet Frogg and Ratt. The 2 degens riding the Suinami.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://xatontgesaqf7cfeboedtsik7xnnz2wespeifbf3igqzifiqi6fa.arweave.net/uCbmzMSQIF-IpAuIOckK_drc6sSTyIKEu0GhlBUQR4o")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FRATT>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRATT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<FRATT>>(0x2::coin::mint<FRATT>(&mut v2, 16969696900, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

