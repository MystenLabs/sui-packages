module 0x87ee1f1306ed67c8671a59bde76c05f599bceab09639e124693091cbb5f9315b::happy {
    struct HAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAPPY>(arg0, 9, b"HAPPY", b"Cross cat", b"Duo colour cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/09b36e9c-b000-46e4-ae7f-0c9e252a102e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

