module 0xf37bea883ee87b07d4689170e58155af85687baebd2dfa78ed28528bae03ac56::suiguy {
    struct SUIGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGUY>(arg0, 6, b"SUIGUY", b"THEREALSYIGUY", b"Guysui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid4c62lpsdjxgpysovmew3erarlmzwmycex7k5upjwd5z2ya24rge")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIGUY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

