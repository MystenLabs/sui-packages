module 0x6678eca24104dd20ee641aede13e24dbcab5ea0ae399ab44b50a64d3ceb0d8fa::wow {
    struct WOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOW>(arg0, 9, b"WOW", b"Pepep", b"Noonnoon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e5f686ae-2391-485c-894f-045f44279db9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

