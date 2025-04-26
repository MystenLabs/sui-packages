module 0x642805fd63ba44fe3df1ef69b26cfc263e7b73bf4f69f470ff7c5037083892f0::yuki {
    struct YUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUKI>(arg0, 6, b"YUKI", b"LOFI's Son", b"$YUKI is a cute fluffy furred Yeti and Son of LOFI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifgbun7uqwkqjccw6csqvjvljetgqjj3v5zkr77fxa3gqdy5t4gva")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YUKI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

