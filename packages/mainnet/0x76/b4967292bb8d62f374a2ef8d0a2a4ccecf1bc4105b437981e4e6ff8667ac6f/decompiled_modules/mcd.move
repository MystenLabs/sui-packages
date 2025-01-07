module 0x76b4967292bb8d62f374a2ef8d0a2a4ccecf1bc4105b437981e4e6ff8667ac6f::mcd {
    struct MCD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCD>(arg0, 9, b"MCD", b"McDonald's", b"grimace is a close personal friend of mine", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/767c3da9-c895-48ee-a35e-074625c17168.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCD>>(v1);
    }

    // decompiled from Move bytecode v6
}

