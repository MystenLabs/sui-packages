module 0x260ede11d097cbd26624cc95ef7eeeb94e8769db0eaa7f591517d4f19dfb1a3f::dede {
    struct DEDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEDE>(arg0, 6, b"DEDE", b"DEDE FROG", b"$DEDE 0xDD69 is a groundbreaking cryptocurrency inspired by Matt Furie's iconic character Dodge-Daddy the Fastfrog from the HEADZ NFT collection. Embracing the ethos of creativity and community-driven culture that defines Furie's art, $DEDE pays homage to the fast-moving spirit of Dodge-Daddy while carving its unique path in the crypto space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/S_He_Cqa5u_400x400_ca9b094e79.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

