module 0x6a0c9eb88ba3ec417db25afc5ae64f07e2be2dd05d3c65e8c6cb7f125d65808b::wmb {
    struct WMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: WMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WMB>(arg0, 9, b"WMB", b"Embun", b"type of crypto created primarily for entertainment purposes and the expression of humor, often inspired by or using popular internet images and memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aecfc9cf-f02d-4780-9f1b-1aac06a16237.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

