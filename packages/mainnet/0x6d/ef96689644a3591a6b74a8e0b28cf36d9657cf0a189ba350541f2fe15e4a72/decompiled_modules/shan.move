module 0x6def96689644a3591a6b74a8e0b28cf36d9657cf0a189ba350541f2fe15e4a72::shan {
    struct SHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAN>(arg0, 9, b"SHAN", b"SHAMS", b"SHAMSSHAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ec2215d4-8b7a-4829-b29c-25f823dc5df6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

