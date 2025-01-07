module 0xf22647ec61328c8998b5609fd4dd48987310b095315130ca039dcf6d26b6f4be::ptk {
    struct PTK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTK>(arg0, 9, b"PTK", b"Puttotalk", b"Silen or talk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/333849e9-744a-4aa3-ad17-7ae53f61d291.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTK>>(v1);
    }

    // decompiled from Move bytecode v6
}

