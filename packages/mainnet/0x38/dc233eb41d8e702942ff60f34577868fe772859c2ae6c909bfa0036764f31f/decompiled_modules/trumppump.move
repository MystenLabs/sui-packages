module 0x38dc233eb41d8e702942ff60f34577868fe772859c2ae6c909bfa0036764f31f::trumppump {
    struct TRUMPPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPPUMP>(arg0, 9, b"TRUMPPUMP", b"Trump", b"Stay tuned and buy the Kevin Trump meme that will grow exponentially if he succeeds in the election ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1d243a20-9b75-43bc-8ea3-560730434534.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

