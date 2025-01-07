module 0x359a03d61746edc87db1be28823fd648f0c19e3a7d83cd4451cbd10e56f17841::bv {
    struct BV has drop {
        dummy_field: bool,
    }

    fun init(arg0: BV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BV>(arg0, 9, b"BV", b"HT", b"XVC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ec6c58f1-3396-4f78-9b23-66ede666e313.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BV>>(v1);
    }

    // decompiled from Move bytecode v6
}

