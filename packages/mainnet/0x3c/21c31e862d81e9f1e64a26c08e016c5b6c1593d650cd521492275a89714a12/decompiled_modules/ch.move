module 0x3c21c31e862d81e9f1e64a26c08e016c5b6c1593d650cd521492275a89714a12::ch {
    struct CH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CH>(arg0, 9, b"CH", b"Checkin", b"Chekin Daily", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1c75df91-cc69-47bd-bb7b-edfee0473066.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CH>>(v1);
    }

    // decompiled from Move bytecode v6
}

