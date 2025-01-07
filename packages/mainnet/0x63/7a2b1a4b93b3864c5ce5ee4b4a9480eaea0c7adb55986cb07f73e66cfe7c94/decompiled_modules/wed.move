module 0x637a2b1a4b93b3864c5ce5ee4b4a9480eaea0c7adb55986cb07f73e66cfe7c94::wed {
    struct WED has drop {
        dummy_field: bool,
    }

    fun init(arg0: WED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WED>(arg0, 9, b"WED", b"WEWEPUMPS", b"Wewepumps", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/efa0b5a9-995f-4e97-8bc2-d505ba7cc518.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WED>>(v1);
    }

    // decompiled from Move bytecode v6
}

