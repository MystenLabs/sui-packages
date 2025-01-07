module 0xd16482ac279ee7948512e538e522c7fc0964848c6aef24e1567bc801f2bbfc4f::sho {
    struct SHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHO>(arg0, 9, b"SHO", b"Shoes", b"Meme of Shoes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/33822f06-4c60-436c-b0a8-6eea85c7a967.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

