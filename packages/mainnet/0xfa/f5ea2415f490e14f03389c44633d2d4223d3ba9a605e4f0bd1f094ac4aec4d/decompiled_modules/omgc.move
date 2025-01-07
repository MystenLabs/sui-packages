module 0xfaf5ea2415f490e14f03389c44633d2d4223d3ba9a605e4f0bd1f094ac4aec4d::omgc {
    struct OMGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMGC>(arg0, 9, b"OMGC", b"OIMAIGOT", b"oivaicalon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b9712199-861d-47e4-a243-dc31b2568c8d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMGC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OMGC>>(v1);
    }

    // decompiled from Move bytecode v6
}

