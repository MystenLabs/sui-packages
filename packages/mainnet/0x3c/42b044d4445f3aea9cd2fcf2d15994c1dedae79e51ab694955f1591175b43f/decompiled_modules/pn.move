module 0x3c42b044d4445f3aea9cd2fcf2d15994c1dedae79e51ab694955f1591175b43f::pn {
    struct PN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PN>(arg0, 6, b"PN", b"PANDA NEX", b"PANDA ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieest377shrcw5nhrfhvfxq7p34ltobn3q4gohculponj2m2qm3ji")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

