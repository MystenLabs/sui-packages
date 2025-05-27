module 0x4c37b92ec0c7c895bf52bf0433c90865d458f30931c4e7a33e6bc4a2b2eacb9f::age {
    struct AGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGE>(arg0, 6, b"AGE", b"Ape Genesis", b"Ape Era", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiff4x3pvas3ga6adikkcyy462hmlxnww4brr7zvztfufheqinb2ae")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AGE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

