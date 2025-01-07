module 0xc464c81e058b93dbb99ba60407c29d71cc29aa5a256298324f08ba08bdc088e2::csi {
    struct CSI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CSI>, arg1: 0x2::coin::Coin<CSI>) {
        0x2::coin::burn<CSI>(arg0, arg1);
    }

    fun init(arg0: CSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSI>(arg0, 9, b"CSI", b"CSI888", b"CSI888", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTuir6dwkgQrfa8sAsVhewB7ZgbmUgdSLamzX7m511mKC")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CSI>(&mut v2, 25000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CSI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSI>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CSI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CSI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

