module 0xafe5f48fe0816bcb0752f5d749ee4caa005355e624cfd8814309b2587e7f8e18::ptk {
    struct PTK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTK>(arg0, 9, b"PTK", b"Puttotalk", b"Silen or talk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fa6b13cf-6cbc-43de-9160-e931151f5555.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTK>>(v1);
    }

    // decompiled from Move bytecode v6
}

