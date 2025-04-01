module 0x83587899cdd86be56357f8e6e40ebd33a29e08c2bfa586aeb80c12fcd203a9df::whfi {
    struct WHFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHFI>(arg0, 6, b"whFI", b"WheatFI", x"576865617446492069732061207265776172642d626173656420746f6b656e2064657369676e656420746f2067726f7720696e2076616c7565206f7665722074696d6520627920616363756d756c6174696e67207374616b696e6720726577617264732e20556e6c696b6520747261646974696f6e616c20746f6b656e732c205768656174464920646f6573206e6f7420696e63726561736520696e20737570706c79e28094696e73746561642c206561636820746f6b656e206265636f6d657320776f727468206d6f7265206173207265776172647320636f6d706f756e642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/bb3ba61a-3bc5-408e-b579-166dc4564a33.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHFI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHFI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

