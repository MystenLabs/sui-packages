module 0x44310bf4a0ec0e9861b57ec901df7047d185bfcc1f29446a6b50f1e1085dd70a::wewefun {
    struct WEWEFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWEFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWEFUN>(arg0, 9, b"WEWEFUN", b"JustForFun", b"Tickle my fancy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3f7274c9-29c0-4636-af79-ac44355157bd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWEFUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWEFUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

