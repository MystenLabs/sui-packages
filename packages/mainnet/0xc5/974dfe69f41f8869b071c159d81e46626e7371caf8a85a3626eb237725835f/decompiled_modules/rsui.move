module 0xc5974dfe69f41f8869b071c159d81e46626e7371caf8a85a3626eb237725835f::rsui {
    struct RSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RSUI>(arg0, 9, b"RSUI", b"Rocket Sui", b"A sleek, colorful cartoon rocket with a shiny metallic body, pointed nose cone, and three fins. Adorned with bright red and blue stripes, it blasts off with flames and smoke trailing behind, capturing the excitement of space travel. launch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6987594a-bc55-4b90-826f-8c1e7c584b4d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

