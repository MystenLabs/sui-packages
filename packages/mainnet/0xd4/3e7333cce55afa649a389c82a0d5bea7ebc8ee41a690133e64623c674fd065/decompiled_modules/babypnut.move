module 0xd43e7333cce55afa649a389c82a0d5bea7ebc8ee41a690133e64623c674fd065::babypnut {
    struct BABYPNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYPNUT, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BABYPNUT>(arg0, 11242828294647491660, b"BabyPnut", b"BabyPnut", b"BabyPnut on HOP", b"https://images.hop.ag/ipfs/QmZuPfC2UaBnXL83QrJ1mtZcDxDsvyCwkgAhAqDscri7mD", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

