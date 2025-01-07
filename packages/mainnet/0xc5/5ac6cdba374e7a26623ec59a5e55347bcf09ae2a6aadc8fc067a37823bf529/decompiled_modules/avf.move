module 0xc55ac6cdba374e7a26623ec59a5e55347bcf09ae2a6aadc8fc067a37823bf529::avf {
    struct AVF has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVF>(arg0, 9, b"AVF", b"dsg", b"CX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e9d08df8-90e6-489b-a28d-9ad5b2d3b5a0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AVF>>(v1);
    }

    // decompiled from Move bytecode v6
}

