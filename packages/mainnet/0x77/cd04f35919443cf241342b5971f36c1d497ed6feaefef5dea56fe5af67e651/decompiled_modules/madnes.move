module 0x77cd04f35919443cf241342b5971f36c1d497ed6feaefef5dea56fe5af67e651::madnes {
    struct MADNES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MADNES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MADNES>(arg0, 6, b"MADNES", b"SUI MADNES", b"SUI MADNES :: Simply SUI MADNES - following in the footsteps of SUI, promoting SUI and praising the idea of SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibgauruhwyzkjgev2uie237kta3uxk27snqfhnnmpaxm4f3ivunwy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MADNES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MADNES>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

