module 0x705e7d8849ceab376efbaf3dab7a8d613ed89b3372f52f51c80672e880cc175b::alpha {
    struct ALPHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALPHA>(arg0, 6, b"ALPHA", b"King Charles the Alpha Dog", b"King Charles the Alpha Dog went viral by doing nothing, just staring like a boss. Now he's taking over the Sui Network as $ALPHA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidcvvsmzgpfvrxhsx33k5hcbfn6rhbub3l6ekwe7tfbm5jxdff6pe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ALPHA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

