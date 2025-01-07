module 0x2e6bde467316394addcf78cf49849b76c67117d484c9857604a8dbf37ceded19::odu {
    struct ODU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ODU>(arg0, 9, b"ODU", b"One Dollar Unicorn", x"4120756e69636f726e20746861742773206120646f6c6c61722e0a0a68747470733a2f2f742e6d652f646f6c6c6172756e69636f726e0a0a68747470733a2f2f782e636f6d2f646f6c6c6172756e69636f726e0a0a68747470733a2f2f6f6e65646f6c6c6172756e69636f726e2e636f6d2f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"hhttps://gateway.pinata.cloud/ipfs/QmUHxom3yv4G3zzbv8WrBXjao2GyGRHGVJiGmp74h7bzPX/image.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ODU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ODU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

