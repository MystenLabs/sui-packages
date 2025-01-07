module 0xdf6674aa7d326a0496395ab079ce518d56c3144b04854e866905788b19b9b59::by311 {
    struct BY311 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BY311, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BY311>(arg0, 9, b"BY311", b"AIY", b"AI THE FEATURE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0242dbea-57d5-47a1-8d00-680202f95e55.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BY311>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BY311>>(v1);
    }

    // decompiled from Move bytecode v6
}

