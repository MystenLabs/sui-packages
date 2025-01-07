module 0x16ad5d6770471e91d52a1c485bbf3a38a6bc2de3b90fc169aa100497bc22363a::i {
    struct I has drop {
        dummy_field: bool,
    }

    fun init(arg0: I, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<I>(arg0, 9, b"I", b"LOVE", b"HAVE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/afccc583-1891-47d1-bfb3-fae89c05e075.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<I>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<I>>(v1);
    }

    // decompiled from Move bytecode v6
}

