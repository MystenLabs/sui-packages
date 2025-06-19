module 0xd1701d78ee7d8ed76b64c5050f29ce94f9a15b36ccffab413a4dc5fbfdc913d7::s {
    struct S has drop {
        dummy_field: bool,
    }

    fun init(arg0: S, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S>(arg0, 8, b"S", b"Slaunch (S)", x"54686520466972737420496e697469616c20417474656e74696f6e204f66666572696e67204f6e200a405375694e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/5b51b20e-f571-404d-a6ee-58bf32a44e61.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<S>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<S>>(v1);
    }

    // decompiled from Move bytecode v6
}

