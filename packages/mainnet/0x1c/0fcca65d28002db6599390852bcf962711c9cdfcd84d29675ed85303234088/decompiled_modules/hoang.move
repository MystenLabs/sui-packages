module 0x1c0fcca65d28002db6599390852bcf962711c9cdfcd84d29675ed85303234088::hoang {
    struct HOANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOANG>(arg0, 9, b"HOANG", b"Cuong", b"Lac lam dong duong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e5e3f2b3-ddb8-4b08-8bda-a1ea4046cf25.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

