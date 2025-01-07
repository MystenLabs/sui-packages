module 0xce1b96bea334e5f9c69a26e9f53b056badc0f5cd9295a9d3da263ca0cf818240::amstr {
    struct AMSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMSTR>(arg0, 9, b"AMSTR", b"Amsterdam", b"Big City Live", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3d2cecfe-50c7-4609-8cf6-3b66fd8384ea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMSTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMSTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

