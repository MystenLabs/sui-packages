module 0xc8575babdd272240c4c3ab969b21335d579a9787440f935c4a970c811d4c3a08::gun {
    struct GUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUN>(arg0, 9, b"GUN", b"gun", b"the winner", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fc10b36b-1415-4407-9505-2a631c7f3a77.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

