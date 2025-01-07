module 0x1cbefd767a7db7e35f3376c3d7c39c0f4d76ad68e54a5b3e856d74bdb58d3399::quant {
    struct QUANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUANT>(arg0, 6, b"QUANT", b"GEN Sui QUANT", x"496d6167696e652047657474696e6720527567676564204f66202433306b2042792041204348494c44e29d97efb88f0a0a54686973206b69642063726561746564206120636f696e2063616c6c656420245155414e54207468656e2064756d706564206f6e20686f6c6465727320666f72202433306b207768696c65206c6976652d73747265616d696e67e280bcefb88f0a0a546865206b696e64206f66206372617a7920737475666620746861742068617070656e73206f6e20746869732073706163652063616e20626520756e62656c69657661626c6520736f6d6574696d657320f09f98850a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732086100183.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QUANT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUANT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

