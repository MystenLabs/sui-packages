module 0x8aaba6780690b98d2323f48c24c4a20555c278563571d5c930de38d17e0f9001::dkc {
    struct DKC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DKC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DKC>(arg0, 9, b"DKC", b"Dance ", b"Duck is the only thing ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/490e50a4-34fa-48e6-9b3d-35e5e0d6a092.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DKC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DKC>>(v1);
    }

    // decompiled from Move bytecode v6
}

