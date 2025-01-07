module 0x54a86689705ef766371abe5fa1f51ff440522ec45a66514b9221feae821e6e63::dbr {
    struct DBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBR>(arg0, 6, b"DBR", b"deBridgeFinance", b"The bridge that moves at lightspeed. Because DeFi doesn't wait.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Av_Tkqx_TF_400x400_187903c368.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DBR>>(v1);
    }

    // decompiled from Move bytecode v6
}

