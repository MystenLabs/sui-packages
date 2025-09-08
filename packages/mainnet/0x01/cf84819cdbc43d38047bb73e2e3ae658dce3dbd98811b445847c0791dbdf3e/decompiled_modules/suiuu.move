module 0x1cf84819cdbc43d38047bb73e2e3ae658dce3dbd98811b445847c0791dbdf3e::suiuu {
    struct SUIUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIUU>(arg0, 6, b"SUIUU", b"Sui iuu", b"Sui iuuuuu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiepv6ygkstftnucesfpz4v5wf4apxaj36qnosw7ewhd63yrsru464")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIUU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

