module 0x6d7a0459bae683c0528baaa4a0f8e2dd12aa256874b7b0879b7783e8161f256d::wf {
    struct WF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WF>(arg0, 9, b"WF", b"jh", b"df", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/345ba055-b6f1-46ae-b096-c69b997f111a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WF>>(v1);
    }

    // decompiled from Move bytecode v6
}

