module 0x6e6e821dd1ced44b49c006d496e41f3ce5c3491c973dadccf039dba0e0c9ce06::sadant {
    struct SADANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADANT>(arg0, 6, b"SADANT", b"Sad Ant", b"The saddest meme token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fs_Zx_VV_9_N_400x400_5e9ddc711f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADANT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SADANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

