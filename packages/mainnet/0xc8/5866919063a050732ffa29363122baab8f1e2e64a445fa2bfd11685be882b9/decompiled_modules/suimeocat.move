module 0xc85866919063a050732ffa29363122baab8f1e2e64a445fa2bfd11685be882b9::suimeocat {
    struct SUIMEOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMEOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEOCAT>(arg0, 9, b"SUIMEOCAT", b"Suimeo cat", b"Rizz cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a5da389b-4147-4d46-a418-da16b67678b7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMEOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMEOCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

