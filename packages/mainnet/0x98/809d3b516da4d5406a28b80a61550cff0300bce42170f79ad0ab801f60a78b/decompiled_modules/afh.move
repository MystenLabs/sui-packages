module 0x98809d3b516da4d5406a28b80a61550cff0300bce42170f79ad0ab801f60a78b::afh {
    struct AFH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFH>(arg0, 9, b"AFH", b"Affan", b"Affan kanin hanif ne ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/43df353f-cc57-4202-bc48-bc081aaa898e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AFH>>(v1);
    }

    // decompiled from Move bytecode v6
}

