module 0x3b9ec49f118ba680d033bad2d05774f37df4c76618c6c62b54f31d5bc4ab53c0::fufafa {
    struct FUFAFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUFAFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUFAFA>(arg0, 9, b"FUFAFA", b"fufufafafa", b"most trending twitter on indonesia", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/361e9fb0-6ea7-4355-ad00-2533de34e42a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUFAFA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUFAFA>>(v1);
    }

    // decompiled from Move bytecode v6
}

