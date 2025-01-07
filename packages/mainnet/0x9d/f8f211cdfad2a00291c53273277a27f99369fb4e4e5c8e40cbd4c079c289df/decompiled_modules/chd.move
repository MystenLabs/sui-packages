module 0x9df8f211cdfad2a00291c53273277a27f99369fb4e4e5c8e40cbd4c079c289df::chd {
    struct CHD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHD>(arg0, 9, b"CHD", b"childhood", b"excited", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b983a054-79d6-48d7-9d26-bfa89a66e5de.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHD>>(v1);
    }

    // decompiled from Move bytecode v6
}

