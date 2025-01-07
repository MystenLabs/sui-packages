module 0xc8783c60e92b9beca9b6da171fa3214025dbeafb49d030ee3d7f00a9ec20678::mjr {
    struct MJR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MJR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MJR>(arg0, 9, b"MJR", b"MAJOR", b"major major", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1bb34018-1bd9-4668-a353-b0350e33ea78.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MJR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MJR>>(v1);
    }

    // decompiled from Move bytecode v6
}

