module 0x8ceb9a57d6efcb27c4f31928bb6fb28495ef7e3f636b85674576b8d80b55fd5b::pui {
    struct PUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUI>(arg0, 6, b"Pui", b"Pupui", b"Pupuimeme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidsnxamnlkgs6ctxs4qvgfdyz7sv45iptct6srv47bvdi47ybhfkm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

