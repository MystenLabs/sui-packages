module 0xe2dbec20aee8bd8e214edc440c38b16a16cf5b64e9286927f1fe659fe9877310::acard {
    struct ACARD has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ACARD>, arg1: 0x2::coin::Coin<ACARD>) {
        0x2::coin::burn<ACARD>(arg0, arg1);
    }

    fun init(arg0: ACARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACARD>(arg0, 4, b"ACARD", b"BLUE NFC CARD", b"[BLUE NFC CARD] PLEASE VISIT BLUENFCCARD.COM FOR MORE DETAILS. THANK YOU.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiekr6qruhzhhg3ysy4dzc5r6j6rlnav3ckv22grhamkbetftapouu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACARD>>(v1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ACARD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ACARD>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

