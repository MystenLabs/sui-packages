module 0xe6c170e46d49b811a082184e1051a9362c3e0f4e70aa8a062835d51b7861be19::bret {
    struct BRET has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRET>(arg0, 6, b"BRET", b"BRETSUI", b"The bitch of SUI. The only girl manages to sleep with all members of the Boys Club, enjoys her power and attention. Despite initial resistance, they eventually succumb to her charms, creating drama and chaos.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_28_16_07_08_b1a52ae0d2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRET>>(v1);
    }

    // decompiled from Move bytecode v6
}

