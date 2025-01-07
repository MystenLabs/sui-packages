module 0x70093dc8ebd95977bf9f492876b0ff445776103c3f8e7a3fa1660b676ac74199::ryan {
    struct RYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RYAN>(arg0, 9, b"RYAN", b"Ryan Nguye", x"486fc3a06e672074e1bbad2062e1bb8b70", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/244cdfa1-e7c8-4727-a938-f069facfd90a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RYAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RYAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

