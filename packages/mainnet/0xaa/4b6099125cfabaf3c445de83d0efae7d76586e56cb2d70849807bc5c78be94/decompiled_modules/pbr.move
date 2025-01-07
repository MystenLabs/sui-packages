module 0xaa4b6099125cfabaf3c445de83d0efae7d76586e56cb2d70849807bc5c78be94::pbr {
    struct PBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PBR>(arg0, 9, b"PBR", b"Porelessbr", b"Uniquely created indivisible poreless bress", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aaaecb61-84bc-4475-8d07-ac5e1c452d0b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PBR>>(v1);
    }

    // decompiled from Move bytecode v6
}

