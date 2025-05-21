module 0xfea623ee6b22b6f6a4bbc54fe77cb5358c01dc6983efa66198775a82a56be767::boochie {
    struct BOOCHIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOCHIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOCHIE>(arg0, 6, b"BOOCHIE", b"Boochie on Sui", b"Meet $BOOCHIE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigqnlfw2likzywcmxohuh3qcf23id6zzp7ew22re63yrdq6sknwm4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOCHIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOOCHIE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

