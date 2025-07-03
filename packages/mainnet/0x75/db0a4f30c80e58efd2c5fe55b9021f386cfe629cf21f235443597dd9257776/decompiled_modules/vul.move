module 0x75db0a4f30c80e58efd2c5fe55b9021f386cfe629cf21f235443597dd9257776::vul {
    struct VUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: VUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VUL>(arg0, 6, b"VUL", b"Vulcano", b"Dangerous", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreica4yrs43mplmpjyrv6fhkrfi3hp5ozaeabej3nafoa22zhltghfq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VUL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

