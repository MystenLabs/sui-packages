module 0xc15a1aaa18be4ea26efe4eb392eef3789090eaca4b4fd16c89bc3328698245aa::wegot {
    struct WEGOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEGOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEGOT>(arg0, 9, b"WEGOT", b"WAWE", b"WAWE is a meme inspired by the spirit of adventure and freedom with WAWE, we are not just riding the waves - we are mastering them!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4f7ddc1a-ffd4-4c5d-8c54-7c73bfc301fb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEGOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEGOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

