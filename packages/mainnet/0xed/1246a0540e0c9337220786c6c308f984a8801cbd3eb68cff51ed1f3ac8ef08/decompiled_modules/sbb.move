module 0xed1246a0540e0c9337220786c6c308f984a8801cbd3eb68cff51ed1f3ac8ef08::sbb {
    struct SBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBB>(arg0, 9, b"SBB", b"Babysui", b"Babysui : SBB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1bc44731-3f84-4ba9-8c2a-185e3fac90c5-F117F670-B0DE-4CB0-B7FD-1ADFD4CBA0C9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

