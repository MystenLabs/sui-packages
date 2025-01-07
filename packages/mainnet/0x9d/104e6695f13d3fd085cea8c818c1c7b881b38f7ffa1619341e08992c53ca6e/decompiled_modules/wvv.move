module 0x9d104e6695f13d3fd085cea8c818c1c7b881b38f7ffa1619341e08992c53ca6e::wvv {
    struct WVV has drop {
        dummy_field: bool,
    }

    fun init(arg0: WVV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WVV>(arg0, 9, b"WVV", b"wave", b"Powerful like a wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/31ec289b-f6a6-4eb1-a30a-aa3f7c36959a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WVV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WVV>>(v1);
    }

    // decompiled from Move bytecode v6
}

