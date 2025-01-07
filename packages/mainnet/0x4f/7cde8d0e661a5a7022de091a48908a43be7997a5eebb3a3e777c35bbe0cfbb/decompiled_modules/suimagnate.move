module 0x4f7cde8d0e661a5a7022de091a48908a43be7997a5eebb3a3e777c35bbe0cfbb::suimagnate {
    struct SUIMAGNATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAGNATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAGNATE>(arg0, 6, b"SuiMagnate", b"Sui Magnate", b"A symbol of prosperity, he stands confidently atop a mountain of coins, representing ambition and success. With a sharp suit and a visionary mindset, he inspires others to achieve their financial dreams.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_935be5c879.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAGNATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMAGNATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

