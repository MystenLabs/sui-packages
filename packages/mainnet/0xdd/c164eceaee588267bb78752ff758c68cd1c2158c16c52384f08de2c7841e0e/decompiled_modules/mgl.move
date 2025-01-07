module 0xddc164eceaee588267bb78752ff758c68cd1c2158c16c52384f08de2c7841e0e::mgl {
    struct MGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MGL>(arg0, 9, b"MGL", b"MEME GOLD ", b"FARM ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2007d0e3-77b3-4738-b100-ef668b9fa8ae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MGL>>(v1);
    }

    // decompiled from Move bytecode v6
}

