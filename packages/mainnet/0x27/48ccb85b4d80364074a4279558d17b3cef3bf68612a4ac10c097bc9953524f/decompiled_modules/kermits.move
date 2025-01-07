module 0x2748ccb85b4d80364074a4279558d17b3cef3bf68612a4ac10c097bc9953524f::kermits {
    struct KERMITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KERMITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KERMITS>(arg0, 6, b"KERMITS", b"First Kermit on Sui", b"First Kermit on Sui |  https://www.kermitonsui.fun | https://t.me/KermitFrogSui_Portal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Kermit_Frog_0437bf76bd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KERMITS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KERMITS>>(v1);
    }

    // decompiled from Move bytecode v6
}

