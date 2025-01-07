module 0x32b753b76380400930bc67bf1b90e462b48ef0dde9766fccc7c134e0cdb8e096::sps {
    struct SPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPS>(arg0, 6, b"SPS", b"springsui", b"Liquid staking standard for Sui. sSUI coming soon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Xv_Ruiz_EL_400x400_70c1b5f1a2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

