module 0x8bf846fe83570365f21d6e2cb9e19dc8cebd89255363aaf665e23318be720bd9::rip_cat {
    struct RIP_CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIP_CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIP_CAT>(arg0, 9, b"RIP_CAT", b"Rip Cat", b"The first RIP CAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2ed69c9f-caa9-4f82-8289-26d32f0d52d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIP_CAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIP_CAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

