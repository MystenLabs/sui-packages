module 0xe1c884c79d23ce35d16d94c06af114513a4421f44d62f78d19d9028bf465bce8::b_manifest {
    struct B_MANIFEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MANIFEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MANIFEST>(arg0, 9, b"bmanifest", b"bToken manifest", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MANIFEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MANIFEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

