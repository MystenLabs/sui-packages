module 0xa3bb9225139036e649831ae447c20cdda5e92f97820a60a47b37491d48d62de2::peb {
    struct PEB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEB>(arg0, 6, b"PEB", b"Pepe Bros", b"Pepe Bross (PEPEB): fun memecoin on Sui, inspired by Pepe. No fees, token burns, united community!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiauaajplwf4qooyt4zlejsfdwtgdfilkagblpu4u6iakhtxuo3evq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

