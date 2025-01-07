module 0x7b94ea16bbeb9525ce3168070befce663d975085350cfc6348f124bfae683552::vcx {
    struct VCX has drop {
        dummy_field: bool,
    }

    fun init(arg0: VCX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VCX>(arg0, 9, b"VCX", b"VB", b"VCXF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c7f92e1d-ff5d-48a3-b1e3-6e0a1172611c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VCX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VCX>>(v1);
    }

    // decompiled from Move bytecode v6
}

