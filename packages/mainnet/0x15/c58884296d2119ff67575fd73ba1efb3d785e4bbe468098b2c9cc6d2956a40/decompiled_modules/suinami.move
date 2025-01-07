module 0x15c58884296d2119ff67575fd73ba1efb3d785e4bbe468098b2c9cc6d2956a40::suinami {
    struct SUINAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINAMI>(arg0, 9, b"SUINAMI", b"Nami On Sui", b"SuiNami Is meme On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1844162010386513920/rwTFQx8E.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUINAMI>(&mut v2, 334000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINAMI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

