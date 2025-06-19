module 0x833fce7c9ca08bc8619eb6078815aebf43307a77f62093f8ffb90134a29c4305::ref {
    struct REF has drop {
        dummy_field: bool,
    }

    fun init(arg0: REF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REF>(arg0, 6, b"REF", b"ygy", b"RF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidjamzhhj5egk6fieufwbfyic5emaek36hmselt2mdjrdn7oine4y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

