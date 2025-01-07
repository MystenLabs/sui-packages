module 0x4684185cd9579785cfa77b0fab5ebd3cef0d518dbda7d67c7b25dcea3e29ae9b::omg {
    struct OMG has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMG>(arg0, 9, b"OMG", b"oimaisgots", b"sup rai to be con to new", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/90893a48-1699-49c2-9c79-c229611ac53d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OMG>>(v1);
    }

    // decompiled from Move bytecode v6
}

