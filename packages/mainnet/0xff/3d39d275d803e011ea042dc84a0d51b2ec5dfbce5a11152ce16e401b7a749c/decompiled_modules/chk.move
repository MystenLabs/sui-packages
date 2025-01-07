module 0xff3d39d275d803e011ea042dc84a0d51b2ec5dfbce5a11152ce16e401b7a749c::chk {
    struct CHK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHK>(arg0, 9, b"CHK", b"CheemsKing", b"King of dogs meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/310c4727-242e-4ed8-b971-ccd9cd74d89d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHK>>(v1);
    }

    // decompiled from Move bytecode v6
}

