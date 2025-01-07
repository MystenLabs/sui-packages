module 0xd4cacd247c8d4f73e6975b13c3bef2ce7f673e17b87a76ec26df01b9bbe4430a::initial {
    struct INITIAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: INITIAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INITIAL>(arg0, 9, b"INITIAL", b"swat", b"My initial name is S.Wa.T.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6e0cadf7-c157-4974-a2e9-94097ffd017b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INITIAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INITIAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

