module 0x5632cb7377a3be50601131c600aa3905299eee4761f1b55ff3ea5fb088b0d6ca::potus {
    struct POTUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POTUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POTUS>(arg0, 9, b"POTUS", b"Kalama", b"MAGA Hedge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5b6e61cb-06cb-469d-a06f-0b43454ce25d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POTUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POTUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

