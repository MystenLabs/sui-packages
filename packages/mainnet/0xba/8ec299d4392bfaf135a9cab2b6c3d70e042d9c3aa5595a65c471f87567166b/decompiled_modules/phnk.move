module 0xba8ec299d4392bfaf135a9cab2b6c3d70e042d9c3aa5595a65c471f87567166b::phnk {
    struct PHNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHNK>(arg0, 9, b"PHNK", b"PHOENIK", b"A majestic and powerful bird soaring over the SUI ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cf1dc647-bacf-4193-ac60-ffe5553eacc4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PHNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

