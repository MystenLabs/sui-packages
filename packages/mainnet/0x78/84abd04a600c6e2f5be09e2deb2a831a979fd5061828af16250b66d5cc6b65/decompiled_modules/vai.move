module 0x7884abd04a600c6e2f5be09e2deb2a831a979fd5061828af16250b66d5cc6b65::vai {
    struct VAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAI>(arg0, 9, b"VAI", b"VITALIK AI", b"Vitalik AI here to bring a huge impact for Solana. Road to SOL=5000$ accepted", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbJiW7ev5FSGjPN3EbuatChY9zuz6LQDbx9sWxCAduRe8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

