module 0x345012082a254e2149f278e50d8a5cb94ad0a694116d6e985b30a66acb113838::of {
    struct OF has drop {
        dummy_field: bool,
    }

    fun init(arg0: OF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OF>(arg0, 6, b"OF", b"OnlyFan Coin", b"OnlyFan Coin is a community-driven token inspired by the creator economy, built for fans, by fans.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia75jmi3dng6pdu2fqtswqwmtuwsjn56lhtpkhoqyeazjreun3tnu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

