module 0x5aa478758a38d5018ed5e11166af42eb746f33bc809b7759e85f400e67732abf::weewe {
    struct WEEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEEWE>(arg0, 9, b"WEEWE", b"WEE", b"MEMEEE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f92d3256-0b1a-4f19-9c79-d387bb559140.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

