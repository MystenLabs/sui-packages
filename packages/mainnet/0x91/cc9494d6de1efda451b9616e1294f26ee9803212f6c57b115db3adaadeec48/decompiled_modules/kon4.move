module 0x91cc9494d6de1efda451b9616e1294f26ee9803212f6c57b115db3adaadeec48::kon4 {
    struct KON4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: KON4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KON4>(arg0, 9, b"KON4", b"Kon4oHHbly", b"Winwinwin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5247d094-8dea-4e45-8d42-f40b9561be27.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KON4>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KON4>>(v1);
    }

    // decompiled from Move bytecode v6
}

