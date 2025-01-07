module 0x91815617ae13216e19e90b4d57d53d0e41c53e5e6341199152ae5f087146a91f::toor {
    struct TOOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOOR>(arg0, 6, b"TOOR", b"Root 2.0", b"New generation of Root, the community meme token of the Rootlets NFT project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_25_alle_21_03_56_c4fa3d2dcf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

