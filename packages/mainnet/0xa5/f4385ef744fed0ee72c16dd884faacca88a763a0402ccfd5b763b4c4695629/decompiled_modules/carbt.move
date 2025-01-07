module 0xa5f4385ef744fed0ee72c16dd884faacca88a763a0402ccfd5b763b4c4695629::carbt {
    struct CARBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARBT>(arg0, 9, b"CARBT", b"car", b"Envision the CAR Memecoin as an exhilarating journey through the world of automobiles.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e7ce35e7-ed20-4a0e-87c8-5c46462591b7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CARBT>>(v1);
    }

    // decompiled from Move bytecode v6
}

