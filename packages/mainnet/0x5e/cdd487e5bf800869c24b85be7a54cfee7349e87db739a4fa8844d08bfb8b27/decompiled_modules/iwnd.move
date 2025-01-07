module 0x5ecdd487e5bf800869c24b85be7a54cfee7349e87db739a4fa8844d08bfb8b27::iwnd {
    struct IWND has drop {
        dummy_field: bool,
    }

    fun init(arg0: IWND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IWND>(arg0, 9, b"IWND", b"jdjd", b"bend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bd21be74-0614-4a26-beb0-f9504d3a6dad.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IWND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IWND>>(v1);
    }

    // decompiled from Move bytecode v6
}

