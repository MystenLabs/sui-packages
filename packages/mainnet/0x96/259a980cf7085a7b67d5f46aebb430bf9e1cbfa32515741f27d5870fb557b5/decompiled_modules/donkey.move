module 0x96259a980cf7085a7b67d5f46aebb430bf9e1cbfa32515741f27d5870fb557b5::donkey {
    struct DONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONKEY>(arg0, 6, b"DONKEY", b"DONKEY SUI", x"41205469636b65722069732024444f4e4b45592e0a24444f4e4b4559203130303058", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicc4hgpjbgyrtuuozwnkl7otlgilz4fqvfxnspny7eegnkdw6mqoy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DONKEY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

