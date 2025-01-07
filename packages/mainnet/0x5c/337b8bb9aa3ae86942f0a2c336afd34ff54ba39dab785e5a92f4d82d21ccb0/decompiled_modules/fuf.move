module 0x5c337b8bb9aa3ae86942f0a2c336afd34ff54ba39dab785e5a92f4d82d21ccb0::fuf {
    struct FUF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUF>(arg0, 9, b"FUF", b"Fufufafa", b"FUF The King ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a52829cd-b4ea-410f-aba0-d02c6de113da-1000169542.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUF>>(v1);
    }

    // decompiled from Move bytecode v6
}

