module 0xd8297b03ef083e3bde1ed598dcf6867227839ca39187ff2210d2cccf455d90de::tdbiu {
    struct TDBIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDBIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDBIU>(arg0, 6, b"TDBIU", b"They Didn't Believe In Us", b"GOD DID!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeih4zjx7btppboikjsiueykqbbctoce3ik2ecfg5jpq2xq4y3founm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TDBIU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TDBIU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

