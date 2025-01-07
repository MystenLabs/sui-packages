module 0xb1901f56d176bdf71a8e220a410ec92eebd602528cbda7295662cc5de8b2b558::sunfish {
    struct SUNFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNFISH>(arg0, 6, b"SUNFISH", b"SUNFISH ON SUI", b"Behold the SUI FISH: rocking a syringe hat and a plastic bag fin like it's straight out of an ocean fashion show. Zero brain, all drip. Floating through life with absolutely no sense of direction but 100% commitment to the vibe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sunfish_logo_3b19a49da8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

