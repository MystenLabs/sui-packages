module 0x8e6d230f428c5e527df5e0af97b907e18112527a07ea2cdae032a12225d68629::sgg {
    struct SGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGG>(arg0, 9, b"SGG", b"ski goggle", b"Better visibility to the market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e7006ad7-b187-42d1-ad51-9acf0050523c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

