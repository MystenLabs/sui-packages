module 0xbd4736c9fbb97d4930ebc58fb3053843e85c785c4a721d716d15dd0b8752ddd8::srl {
    struct SRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRL>(arg0, 9, b"SRL", b"Searuler", b"The Sea god", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ca33b133-cb71-41fe-a674-977d2322799e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

