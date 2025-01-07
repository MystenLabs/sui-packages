module 0xe7f4e396a3721d3571ec82f2981485398d736c9131be69c39084770d57a5bbd2::avf {
    struct AVF has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVF>(arg0, 9, b"AVF", b"dsg", b"CX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c6ce2ec4-fe0b-41fb-87b7-45e784037725.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AVF>>(v1);
    }

    // decompiled from Move bytecode v6
}

