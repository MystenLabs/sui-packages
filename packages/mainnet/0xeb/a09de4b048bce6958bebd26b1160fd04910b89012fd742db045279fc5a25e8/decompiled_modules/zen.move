module 0xeba09de4b048bce6958bebd26b1160fd04910b89012fd742db045279fc5a25e8::zen {
    struct ZEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEN>(arg0, 9, b"ZEN", b"Zen Coin", b"Blending spiritual growth with digital wealth, ZenCoin offers a unique Web3 gaming experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7edf7011-f257-4dd0-827c-2d4375de37ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

