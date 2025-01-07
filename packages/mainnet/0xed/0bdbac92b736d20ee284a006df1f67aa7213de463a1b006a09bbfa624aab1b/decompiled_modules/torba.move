module 0xed0bdbac92b736d20ee284a006df1f67aa7213de463a1b006a09bbfa624aab1b::torba {
    struct TORBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORBA>(arg0, 9, b"TORBA", b"torba", b"Real Torba", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f61996ce-f299-4c59-958b-7dd2d4abfeed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TORBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

