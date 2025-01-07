module 0x3463cfe66dbd4ba3f7fbd5b5bc198c693e0b0418ee8294cf0d34bade830f1269::cof {
    struct COF has drop {
        dummy_field: bool,
    }

    fun init(arg0: COF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COF>(arg0, 9, b"COF", b"Coffee ", b"Best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3280ec08-3284-494a-a04e-507bc246f443.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COF>>(v1);
    }

    // decompiled from Move bytecode v6
}

