module 0x9ab225554b1cd1e8f7734d5304645eae3a5b73e3302e5b00e032350a3a0dc672::st {
    struct ST has drop {
        dummy_field: bool,
    }

    fun init(arg0: ST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ST>(arg0, 9, b"ST", b"Santiago", b"Santiago Bernabeu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4e6ea18b-31e9-4c9a-bc22-e8d9a7922345.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ST>>(v1);
    }

    // decompiled from Move bytecode v6
}

