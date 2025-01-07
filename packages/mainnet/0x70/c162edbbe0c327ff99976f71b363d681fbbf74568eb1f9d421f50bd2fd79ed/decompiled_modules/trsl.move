module 0x70c162edbbe0c327ff99976f71b363d681fbbf74568eb1f9d421f50bd2fd79ed::trsl {
    struct TRSL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRSL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRSL>(arg0, 9, b"TRSL", b"Trishul ", x"f09f94b1205472697368756c20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/07f79116-ba77-483b-88f3-b191ad1533aa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRSL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRSL>>(v1);
    }

    // decompiled from Move bytecode v6
}

