module 0x350e6de45f2d22b7f8dc68eda67664e7300799f018ae5262ff6a57027d1f8c0c::mem {
    struct MEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEM>(arg0, 9, b"MEM", b"EVENPUMP", b"We all believe in the sui ecosystem and its creator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5a810788-a438-4053-ab85-d4f36bf7143a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

