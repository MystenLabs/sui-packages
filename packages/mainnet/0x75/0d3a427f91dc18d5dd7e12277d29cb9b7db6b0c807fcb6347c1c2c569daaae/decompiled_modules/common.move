module 0x750d3a427f91dc18d5dd7e12277d29cb9b7db6b0c807fcb6347c1c2c569daaae::common {
    struct COMMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMMON>(arg0, 9, b"COMMON", b"Common", b"Everything is common no rare, epic, legendary or special", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/17eaab6e-0321-41b7-b4ed-6aac950bc1ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COMMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

