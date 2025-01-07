module 0xfede119a830c0c186d0312bd8ca8148cd8e37dbeeb9469a1b38bddcbc00040f0::bgain {
    struct BGAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BGAIN>(arg0, 9, b"BGAIN", b"ByteGain", b"Youtube Channel Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/71a88093-dabb-4210-ac7d-95e9d0472e7c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BGAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BGAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

