module 0x5f39df9b8c99f5318a07be11ebdc9760664c3ecb41b3249f47dda382b9a96924::ee {
    struct EE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EE>(arg0, 6, b"EE", b"ggfdsf", b"dsqdqsfq", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidyqax22ci5it63nng4gcnvk3ocvp7eeou4beoiy7vi34campwyzi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

