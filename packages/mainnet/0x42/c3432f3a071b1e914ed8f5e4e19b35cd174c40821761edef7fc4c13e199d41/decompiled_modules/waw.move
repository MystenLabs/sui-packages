module 0x42c3432f3a071b1e914ed8f5e4e19b35cd174c40821761edef7fc4c13e199d41::waw {
    struct WAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAW>(arg0, 9, b"WAW", b"wawa", b"WAW token creat for wewe project ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b805f7c0-03ee-406a-98d2-2088aa2d3c82.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

