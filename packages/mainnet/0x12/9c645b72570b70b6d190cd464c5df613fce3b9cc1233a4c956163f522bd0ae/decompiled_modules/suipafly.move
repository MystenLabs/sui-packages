module 0x129c645b72570b70b6d190cd464c5df613fce3b9cc1233a4c956163f522bd0ae::suipafly {
    struct SUIPAFLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPAFLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPAFLY>(arg0, 6, b"SuipaFly", b"Suipa Fly", b"SuipaFLY is a filipino famous rapper and he is crip gangster", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/363417017_1177372503653428_6106933612787919125_n_6a6708850e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPAFLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPAFLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

