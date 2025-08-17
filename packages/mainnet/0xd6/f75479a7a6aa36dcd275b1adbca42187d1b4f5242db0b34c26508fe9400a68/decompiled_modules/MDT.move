module 0xd6f75479a7a6aa36dcd275b1adbca42187d1b4f5242db0b34c26508fe9400a68::MDT {
    struct MDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDT>(arg0, 6, b"MODESTY", b"MDT", x"46616e20746f6b656e20666f72206d6f64657374792e0a406269675f6d6f64657374793031", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafkreiakkgek737vsvigzdzbf3eplevygyqtwunysligtd4eumzgnt6bme")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDT>>(v0, @0x221171c3f7f466c651941b1c51ca1299efe23f61364a49c59c349ffa02a537a9);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

