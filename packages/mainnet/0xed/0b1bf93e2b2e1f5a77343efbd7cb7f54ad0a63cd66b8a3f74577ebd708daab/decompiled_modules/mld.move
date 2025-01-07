module 0xed0b1bf93e2b2e1f5a77343efbd7cb7f54ad0a63cd66b8a3f74577ebd708daab::mld {
    struct MLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MLD>(arg0, 9, b"MLD", b"MemeLord ", b"Igniting vision, fueling success ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c388579d-9a43-4db8-b4f2-f83c7ddfcdc0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

