module 0x2edbc51d07e9ae28eaae9e6cbb5dc8acf74048814eb0105724f72c1de966f12a::dc {
    struct DC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DC>(arg0, 9, b"DC", b"DOM CHRIS", b"A community driven token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/59fb00b3-9602-43c7-bfc6-569fe5c4630c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DC>>(v1);
    }

    // decompiled from Move bytecode v6
}

