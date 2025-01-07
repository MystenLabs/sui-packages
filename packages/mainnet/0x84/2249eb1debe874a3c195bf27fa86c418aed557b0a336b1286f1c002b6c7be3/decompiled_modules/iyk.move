module 0x842249eb1debe874a3c195bf27fa86c418aed557b0a336b1286f1c002b6c7be3::iyk {
    struct IYK has drop {
        dummy_field: bool,
    }

    fun init(arg0: IYK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IYK>(arg0, 9, b"IYK", b"IYKE", b"PERSONAL MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4977e499-5165-47a2-a411-b0e12d116ece.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IYK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IYK>>(v1);
    }

    // decompiled from Move bytecode v6
}

