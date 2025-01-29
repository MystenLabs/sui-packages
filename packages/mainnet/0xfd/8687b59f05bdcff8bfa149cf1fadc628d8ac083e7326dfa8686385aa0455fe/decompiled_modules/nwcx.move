module 0xfd8687b59f05bdcff8bfa149cf1fadc628d8ac083e7326dfa8686385aa0455fe::nwcx {
    struct NWCX has drop {
        dummy_field: bool,
    }

    fun init(arg0: NWCX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NWCX>(arg0, 6, b"NWCX", b"NanoWorldComix", b"Community token of Nano World Comix nimated project.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_N_D_D_D_D_D_N_2025_01_29_112425932_efb4a2ece7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NWCX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NWCX>>(v1);
    }

    // decompiled from Move bytecode v6
}

