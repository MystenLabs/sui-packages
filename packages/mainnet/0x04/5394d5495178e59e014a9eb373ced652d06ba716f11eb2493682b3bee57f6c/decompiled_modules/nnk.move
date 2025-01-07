module 0x45394d5495178e59e014a9eb373ced652d06ba716f11eb2493682b3bee57f6c::nnk {
    struct NNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NNK>(arg0, 9, b"NNK", b"tank", b"We go forward like a tank", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ad68b8ba-51ee-41ee-af29-32bc0ac8c243.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

