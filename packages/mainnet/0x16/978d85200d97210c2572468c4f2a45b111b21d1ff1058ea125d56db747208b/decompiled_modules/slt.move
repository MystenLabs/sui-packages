module 0x16978d85200d97210c2572468c4f2a45b111b21d1ff1058ea125d56db747208b::slt {
    struct SLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLT>(arg0, 9, b"SLT", b"Silit", b"Silit mambu token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4bc72ee2-082a-49cc-9a7e-ff3e3ef53343.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

