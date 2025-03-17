module 0xcf2d466a1fdd6aaf63ce8a6fed0cb58d07c169efe93397ba2f9c4780abed6833::vutran10 {
    struct VUTRAN10 has drop {
        dummy_field: bool,
    }

    fun init(arg0: VUTRAN10, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VUTRAN10>(arg0, 9, b"VUTRAN10", b"vutran10", b"hold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/add47d6b-ca22-4df4-93e5-4e6eb941604d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VUTRAN10>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VUTRAN10>>(v1);
    }

    // decompiled from Move bytecode v6
}

