module 0x94ca03a3cb39d13bcfbd7e9c7446c825890e2b2947b3ae6fcbc25136c55024d9::tonero_45 {
    struct TONERO_45 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONERO_45, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONERO_45>(arg0, 9, b"TONERO_45", b"Tonero", b"For fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/776f0777-31ef-4bac-b0d4-a93c5c5ac02a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONERO_45>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TONERO_45>>(v1);
    }

    // decompiled from Move bytecode v6
}

