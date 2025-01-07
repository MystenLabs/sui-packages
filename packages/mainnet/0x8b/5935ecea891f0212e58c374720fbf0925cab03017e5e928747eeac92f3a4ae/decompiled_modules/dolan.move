module 0x8b5935ecea891f0212e58c374720fbf0925cab03017e5e928747eeac92f3a4ae::dolan {
    struct DOLAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLAN>(arg0, 9, b"DOLAN", b"DOLAN DUCK", b"Super Mega cyle with Dolan duck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e16040ce-8971-4efa-886b-38644221f0e1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOLAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

