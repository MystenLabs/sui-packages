module 0x3c74b581e1ff8339f591e6dd5dd9c65de960209ffd8f7ab677be3f1b89bcbd10::sui_bot {
    struct SUI_BOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_BOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_BOT>(arg0, 9, b"Sui Bot", b"SuiTradingBot", b"0xeb1ccf4aaf2a8b69e152d6b1f98ca68e04c33bc9eea94daed7339ea46e8874ed::SUIBOT::SUIBOT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://y4faljvjlbwlx4bhncowgxki6llxmg6olu5dsdmzhao2k4kacaxq.arweave.net/xwoFpqlYbLvwJ2idY11I8td2G85dOjkNmTgdpXFAEC8?ext=png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_BOT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_BOT>>(v2, @0xb24420dbd7948eb723f055df1eac2706ea24f75c7b37a3d494fd6a8969e89025);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_BOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

