module 0xb92380204f43b5e9d1c444ee8af380a8e2c12d5bce679dbcb9d46547ecc45233::bviet {
    struct BVIET has drop {
        dummy_field: bool,
    }

    fun init(arg0: BVIET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BVIET>(arg0, 9, b"BVIET", b"Busa HuHu", b"Vietnam No 1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cbc916a4-1282-47da-8480-7eaaebcd407e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BVIET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BVIET>>(v1);
    }

    // decompiled from Move bytecode v6
}

