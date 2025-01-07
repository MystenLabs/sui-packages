module 0x9f1085ea38924b6657e62c014eadea8128b08a67bfd177a2b31d8fa2e27fc091::fwk {
    struct FWK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWK>(arg0, 6, b"FWK", b"Frog with knife", b"Hand-Off! Please, leave me alone. The bull frog stated in croaking. Please, set me free into the wilderness to rejoin my family.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_28_011956_34373a854f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWK>>(v1);
    }

    // decompiled from Move bytecode v6
}

