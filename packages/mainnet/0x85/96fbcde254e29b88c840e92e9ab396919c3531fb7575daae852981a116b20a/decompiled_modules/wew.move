module 0x8596fbcde254e29b88c840e92e9ab396919c3531fb7575daae852981a116b20a::wew {
    struct WEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEW>(arg0, 9, b"WEW", b"WeQe", b"Weqe token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0a3c470e-a766-4e9e-ac97-c0b3bdbfd6c4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

