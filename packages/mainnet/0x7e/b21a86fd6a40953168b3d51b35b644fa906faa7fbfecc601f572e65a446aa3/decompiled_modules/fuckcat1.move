module 0x7eb21a86fd6a40953168b3d51b35b644fa906faa7fbfecc601f572e65a446aa3::fuckcat1 {
    struct FUCKCAT1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKCAT1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKCAT1>(arg0, 9, b"FUCKCAT1", b"Fuckcat", b"Fuck cat ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4d651549-80e4-4075-82a0-114486ff891c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKCAT1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUCKCAT1>>(v1);
    }

    // decompiled from Move bytecode v6
}

