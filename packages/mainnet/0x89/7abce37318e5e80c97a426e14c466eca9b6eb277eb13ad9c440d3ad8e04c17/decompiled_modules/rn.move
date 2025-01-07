module 0x897abce37318e5e80c97a426e14c466eca9b6eb277eb13ad9c440d3ad8e04c17::rn {
    struct RN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RN>(arg0, 9, b"RN", b"Rain", b"My name is rain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2178baec-ffe8-4e33-a5bc-06278c34ec3a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RN>>(v1);
    }

    // decompiled from Move bytecode v6
}

