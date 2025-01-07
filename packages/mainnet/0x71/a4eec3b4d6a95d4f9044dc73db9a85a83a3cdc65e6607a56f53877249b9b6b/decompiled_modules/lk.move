module 0x71a4eec3b4d6a95d4f9044dc73db9a85a83a3cdc65e6607a56f53877249b9b6b::lk {
    struct LK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LK>(arg0, 9, b"LK", b"Lucky ", b"LUCKY stresses the role of chance in bringing about a favorable result.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e2509ca3-fc47-4a30-807c-9797db25a647.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LK>>(v1);
    }

    // decompiled from Move bytecode v6
}

