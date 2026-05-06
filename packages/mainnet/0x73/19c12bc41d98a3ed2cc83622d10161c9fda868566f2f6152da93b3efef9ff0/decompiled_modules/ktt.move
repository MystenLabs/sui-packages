module 0x7319c12bc41d98a3ed2cc83622d10161c9fda868566f2f6152da93b3efef9ff0::ktt {
    struct KTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KTT>(arg0, 6, b"KTT", b"kitty", b"Token  new on the Sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic32up2ccq7imfx4mrbjhurtib7iibi655sgcjt6vwjjf6e5kacti")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KTT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

