module 0x463910c107a1bfa8422d02c09d90fb349f15d1baed0b6f84103c20c56ec8006d::sim {
    struct SIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIM>(arg0, 6, b"SIM", b"Sui is magic", b"pure magic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_02_12_201143_dd04dc2829.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

