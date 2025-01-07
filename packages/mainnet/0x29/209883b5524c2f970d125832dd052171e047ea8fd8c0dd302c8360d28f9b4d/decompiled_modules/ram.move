module 0x29209883b5524c2f970d125832dd052171e047ea8fd8c0dd302c8360d28f9b4d::ram {
    struct RAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAM>(arg0, 9, b"RAM", b"rhombus", b"rhombus WORLD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2b939511-a71c-4db6-9dd6-98282e8d47fe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

