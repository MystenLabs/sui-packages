module 0x22944f71503d28a142a22a036cd732712fef47db539735937438eaf9d4fe42da::wa {
    struct WA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WA>(arg0, 9, b"WA", b"Wawa", b"wawa is wewe's younger sister", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3e6ffd42-5133-454d-9296-ecbfd5a968b8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WA>>(v1);
    }

    // decompiled from Move bytecode v6
}

