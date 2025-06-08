module 0x6c9b8be1c91bcf55d9ffce12c227c2dcdff69afa233ae8b4b7dae3a190d9fa03::uke {
    struct UKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: UKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UKE>(arg0, 6, b"UKE", b"UNIKE", b"UNIKE the meme on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicew3c3jcjcdltozbaaa77qsutjv63zdnidm24fv7omoeb4xknuoe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

