module 0xcd3740fff0024588c76f4076c17cec2c5b9dee3f86c2b9560d63943a14133161::wedooo {
    struct WEDOOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEDOOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEDOOO>(arg0, 9, b"WEDOOO", b"WAVE", b"WAWE is a meme inspired by the spirit of adventure and freedom. With WAWE, we are not just riding the waves - we are mastering them!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/737f79ed-10ff-424c-96ba-5654ee782b69.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEDOOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEDOOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

