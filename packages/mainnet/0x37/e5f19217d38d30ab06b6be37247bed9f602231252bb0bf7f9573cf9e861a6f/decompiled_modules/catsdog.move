module 0x37e5f19217d38d30ab06b6be37247bed9f602231252bb0bf7f9573cf9e861a6f::catsdog {
    struct CATSDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSDOG>(arg0, 9, b"CATSDOG", b"Catdog", b"Boost your fundz for 50x", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/268af042-5232-4dd8-bf82-e0d92fe80210.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATSDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

