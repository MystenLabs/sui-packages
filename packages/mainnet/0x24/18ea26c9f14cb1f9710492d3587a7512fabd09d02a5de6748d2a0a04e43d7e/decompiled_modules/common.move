module 0x2418ea26c9f14cb1f9710492d3587a7512fabd09d02a5de6748d2a0a04e43d7e::common {
    struct COMMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMMON>(arg0, 9, b"COMMON", b"Common", b"Everything is common no rare, epic, legendary or special", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/11934fcf-7353-4045-82b8-10c52cde16f4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COMMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

