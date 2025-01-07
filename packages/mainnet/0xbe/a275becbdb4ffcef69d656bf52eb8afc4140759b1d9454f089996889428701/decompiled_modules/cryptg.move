module 0xbea275becbdb4ffcef69d656bf52eb8afc4140759b1d9454f089996889428701::cryptg {
    struct CRYPTG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYPTG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYPTG>(arg0, 9, b"CryptG", b"CryptoGuardian", b"THE GUARDIAN OF THE BLOCKCHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3fd089d5f843ed2f4aaad91486630b0cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRYPTG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYPTG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

