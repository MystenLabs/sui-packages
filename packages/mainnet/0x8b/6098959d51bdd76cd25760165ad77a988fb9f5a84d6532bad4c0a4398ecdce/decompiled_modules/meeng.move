module 0x8b6098959d51bdd76cd25760165ad77a988fb9f5a84d6532bad4c0a4398ecdce::meeng {
    struct MEENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEENG>(arg0, 6, b"MEENG", b"Sui Meeng", x"4f7572206661766f72697465206d656d6520636f696e20697320726163696e6720746f776172647320737563636573732c206a757374206c696b6520746865206c6567656e64617279204d69674d6967210a446f6e74206d697373206f7574206f6e20746865206a6f75726e65792c206a6f696e2074686520636f6d6d756e697479206e6f7720616e642062652070617274206f6620746865207269736521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053104_45ef76ecff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

