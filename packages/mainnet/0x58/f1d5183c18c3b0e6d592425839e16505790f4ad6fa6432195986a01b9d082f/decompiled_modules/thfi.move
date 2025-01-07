module 0x58f1d5183c18c3b0e6d592425839e16505790f4ad6fa6432195986a01b9d082f::thfi {
    struct THFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: THFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THFI>(arg0, 9, b"THFI", b"Tahfizmtar", b"tahfi meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/66a3acfb-4832-47e5-865a-f95bca0ec80f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

