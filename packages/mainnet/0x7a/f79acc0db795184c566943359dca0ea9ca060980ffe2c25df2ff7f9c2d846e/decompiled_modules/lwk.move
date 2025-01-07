module 0x7af79acc0db795184c566943359dca0ea9ca060980ffe2c25df2ff7f9c2d846e::lwk {
    struct LWK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LWK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LWK>(arg0, 9, b"LWK", b"LUWAK", b"meme coin luwak to moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0683a324-bb0c-4105-9634-80884984ab73.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LWK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LWK>>(v1);
    }

    // decompiled from Move bytecode v6
}

