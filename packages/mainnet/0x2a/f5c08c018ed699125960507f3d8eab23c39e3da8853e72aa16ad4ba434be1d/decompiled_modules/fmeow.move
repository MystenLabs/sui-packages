module 0x2af5c08c018ed699125960507f3d8eab23c39e3da8853e72aa16ad4ba434be1d::fmeow {
    struct FMEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: FMEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FMEOW>(arg0, 9, b"FMEOW", b"MEOW", b"Meow Funny on #SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/104552a3-b96b-4385-8a34-ba1344a8c10d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FMEOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FMEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

