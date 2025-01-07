module 0xa382ed2a2e0c5920bb1b9315b674ae86e5a903d5210e66d90bbf2d57d48837ac::mkt {
    struct MKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MKT>(arg0, 9, b"MKT", b"MakosTee", b"Simply meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a5170509-060d-4f76-9d4f-c41043496ab5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MKT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MKT>>(v1);
    }

    // decompiled from Move bytecode v6
}

