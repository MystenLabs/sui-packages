module 0xddf24c8ca9a0fc1e5f57bcd377a6f4deb5a3a9a1cdea895dd8538ed16974203e::poleonsui {
    struct POLEONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLEONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLEONSUI>(arg0, 6, b"POLEonSUI", b"Pole", b"POLE The Bear on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_6068948055681515464_c_b96b6a81e0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLEONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLEONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

