module 0xfadbedd3f6057eee0b110b571efefb098789c7d78904bb299a017aea8fbd2863::wrfr {
    struct WRFR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WRFR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WRFR>(arg0, 9, b"WRFR", b"WARFARE", b"COD WARFARE COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/13571a76-7643-471f-bead-0c74f6ed4345.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRFR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WRFR>>(v1);
    }

    // decompiled from Move bytecode v6
}

