module 0x6c3cd9b388bca420922bfa3ad131c12eeb2dff606043595e7b68897d155fe7d6::fdf {
    struct FDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDF>(arg0, 6, b"FDF", b"ffdfds", b"DFDSDS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidyqax22ci5it63nng4gcnvk3ocvp7eeou4beoiy7vi34campwyzi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FDF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

