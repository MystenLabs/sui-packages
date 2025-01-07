module 0xa138a38bb2fbbaf5aa99adac3c6e4cf438cf959b175b8e37058e2ebc5fbb2192::maz {
    struct MAZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAZ>(arg0, 9, b"MAZ", b"Mazoname", b"Meme 2024 to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/42aff2d9-9348-4b5b-80b1-0ad211c7efa3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

