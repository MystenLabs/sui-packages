module 0x66188f2f36c3a1a7224c3573f0d647488aec874fcb779ed8aada515a619fed6e::brd {
    struct BRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRD>(arg0, 9, b"BRD", b"bird", x"54686520617669616e2063727970746f63757272656e6379207468617427732074616b696e6720666c696768742077697468206665617468657265642070726f666974732c206d616b696e6720796f757220706f7274666f6c696f206173206c6967687420616e642066726565206173206120626972642120f09f90a6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7265b8b1-86ed-47ed-b905-279e93aed272.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

