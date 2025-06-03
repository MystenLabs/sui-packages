module 0xe188b0b0c46e5e8b9805cc2d313e3d74ef21bfcaec80cb1a094ae446b6b87393::h20 {
    struct H20 has drop {
        dummy_field: bool,
    }

    fun init(arg0: H20, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<H20>(arg0, 6, b"H20", b"Watercoin", b"The most valuable resource on earth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihoaogbebwqbbgsjwtlwiuuygoomzvqtb57jnmvl2qvwqwyhk5ybq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<H20>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<H20>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

