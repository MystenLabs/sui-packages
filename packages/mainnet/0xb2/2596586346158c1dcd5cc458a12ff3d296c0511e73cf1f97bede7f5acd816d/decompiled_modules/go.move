module 0xb22596586346158c1dcd5cc458a12ff3d296c0511e73cf1f97bede7f5acd816d::go {
    struct GO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GO>(arg0, 9, b"GO", b"Cat", b"Is memefad to moud", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4f17ae94-d93f-4f3e-80ec-cbd8eeef5ca7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GO>>(v1);
    }

    // decompiled from Move bytecode v6
}

