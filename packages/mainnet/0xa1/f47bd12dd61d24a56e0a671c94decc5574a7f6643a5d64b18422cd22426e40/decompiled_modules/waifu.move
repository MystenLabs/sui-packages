module 0xa1f47bd12dd61d24a56e0a671c94decc5574a7f6643a5d64b18422cd22426e40::waifu {
    struct WAIFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAIFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAIFU>(arg0, 9, b"WAIFU", b"$WAIFU", x"24574149465520436c69636b20746f20756e64726573732068657220f09faba6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0a4a7b21-b334-4543-9896-a5d471c2b77f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAIFU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAIFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

