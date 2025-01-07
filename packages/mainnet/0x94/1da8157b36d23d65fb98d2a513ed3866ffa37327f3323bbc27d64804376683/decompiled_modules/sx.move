module 0x941da8157b36d23d65fb98d2a513ed3866ffa37327f3323bbc27d64804376683::sx {
    struct SX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SX>(arg0, 9, b"SX", b"Seex", b"Probably nothing ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d249a23a-a39c-4557-a33c-9a93e21beebf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SX>>(v1);
    }

    // decompiled from Move bytecode v6
}

