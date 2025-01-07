module 0xfe46f3059ebe551b50b04631f56078f4e6df74015bd7331854aacb188b1fe774::bulla {
    struct BULLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLA>(arg0, 6, b"BULLA", b"BullaBulla", b"Rebirth of Bulla Bulla on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bulla_Bulla_f79087dc23.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

