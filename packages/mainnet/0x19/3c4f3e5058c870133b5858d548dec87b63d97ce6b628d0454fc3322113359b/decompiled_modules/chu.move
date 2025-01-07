module 0x193c4f3e5058c870133b5858d548dec87b63d97ce6b628d0454fc3322113359b::chu {
    struct CHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHU>(arg0, 9, b"CHU", b"Chuchu", b"Chuchu is mouse meme coin for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5f6bb918-7449-44a6-a312-16b94c816496.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

