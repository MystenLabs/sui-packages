module 0xe971ef537f704dd81d2d18eb82bac48d20c8ead100bbf2b075dbc4e68d59bfb0::sbtc {
    struct SBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBTC>(arg0, 6, b"Sbtc", b"Bitcoin on Sui", b"Bitcoin in sui now $Sbtc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/70_TTG_Bml_400x400_b8ed6d7b9d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

