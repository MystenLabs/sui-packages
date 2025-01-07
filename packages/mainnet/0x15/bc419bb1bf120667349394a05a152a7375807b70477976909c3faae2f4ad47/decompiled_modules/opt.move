module 0x15bc419bb1bf120667349394a05a152a7375807b70477976909c3faae2f4ad47::opt {
    struct OPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPT>(arg0, 9, b"OPT", b"Optimistic", b"Always be optimistic and confident.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/769cbfe2-de4e-4795-9e6f-1c28b3cbfe52.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

