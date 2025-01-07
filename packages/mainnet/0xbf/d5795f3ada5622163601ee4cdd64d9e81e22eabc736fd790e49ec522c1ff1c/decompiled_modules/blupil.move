module 0xbfd5795f3ada5622163601ee4cdd64d9e81e22eabc736fd790e49ec522c1ff1c::blupil {
    struct BLUPIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUPIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUPIL>(arg0, 9, b"BLUPIL", b"Bluepill", b"Normies tablet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/236e06c5-e5c1-43da-b283-a78d0b7d97be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUPIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUPIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

