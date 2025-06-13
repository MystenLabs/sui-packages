module 0x47c8e51390f328988be647b1f7a92030ad30ce8f014c13db53f80a253559550::dude {
    struct DUDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUDE>(arg0, 6, b"DUDE", b"DUDE DOG", b"Dude has always been about go big or go home. Well.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreienre5kgyntxtbulox7y7f6bgakelox32mpjt4qcueized6oeky2e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DUDE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

