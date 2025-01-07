module 0xeb93acf59e12f8e6b98efa33d0f9a9dc601c9bcbb6e793093aa0181077c2b888::ssh {
    struct SSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSH>(arg0, 6, b"SSH", b"Shrimp ", b" first Pepe shrimp inside light blue Sui sea ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733278406354.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

