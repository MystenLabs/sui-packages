module 0x490c8968eb4bde853178f9d90b2755b90b9226c499412b8cd39aaa211b1c6d32::vanis {
    struct VANIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VANIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VANIS>(arg0, 6, b"VANIS", b"Vani For Sui", b"VANIFOR SUI : Let's go to the moon together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeib34q3x6alued4ou5tjqcujpmmfacyrp67lsfb6tik7vx7xcub2gu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VANIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VANIS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

