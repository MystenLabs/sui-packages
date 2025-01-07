module 0xfd68596a426403b0ea76f110353586c221c2abb113422ce494eced4de2c5d7ab::ghx {
    struct GHX has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHX>(arg0, 9, b"GHX", b"GamerCoin", b"gamefi coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dd668537-ec3c-4bd6-8309-6865fa49b5ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GHX>>(v1);
    }

    // decompiled from Move bytecode v6
}

