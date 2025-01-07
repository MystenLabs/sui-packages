module 0x44942227ab33baabec59d25ce3a26436daba52a93734611b7324a2a283bb407c::ht {
    struct HT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HT>(arg0, 9, b"HT", b"Doggs", b"Dogssss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/83ac4749-2102-410e-a5b3-0520435ba293.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HT>>(v1);
    }

    // decompiled from Move bytecode v6
}

