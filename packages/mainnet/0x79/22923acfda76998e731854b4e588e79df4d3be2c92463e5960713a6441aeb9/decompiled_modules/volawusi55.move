module 0x7922923acfda76998e731854b4e588e79df4d3be2c92463e5960713a6441aeb9::volawusi55 {
    struct VOLAWUSI55 has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOLAWUSI55, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOLAWUSI55>(arg0, 9, b"VOLAWUSI55", b"$VTKN", b"To make money ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4cb8dcef-9ee4-46e1-aa4a-782beb2bc213.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOLAWUSI55>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VOLAWUSI55>>(v1);
    }

    // decompiled from Move bytecode v6
}

