module 0xace4e4a225e13a8c9f68645d3da53262f6f3d11092e3feb39a273efe36aa0150::auraguy {
    struct AURAGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURAGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AURAGUY>(arg0, 6, b"AURAGUY", b"Aura Guy", b"Just an Aura Guy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifrkd44vyb2wgcypksa34hrqbkgsqojmwr6pl4v6judpqvnoixkde")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AURAGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AURAGUY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

