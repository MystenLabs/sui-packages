module 0x1d692975c9543acd21ed172b8d8b115903c19016cafff054ab7985a38ecf0686::pk {
    struct PK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PK>(arg0, 9, b"PK", b"Zong", b"Zong Khala", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3c7db963-56e0-4b96-aaf3-ef59fca872e1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PK>>(v1);
    }

    // decompiled from Move bytecode v6
}

