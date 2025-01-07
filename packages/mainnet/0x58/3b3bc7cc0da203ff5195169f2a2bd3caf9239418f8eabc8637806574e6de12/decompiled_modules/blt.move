module 0x583b3bc7cc0da203ff5195169f2a2bd3caf9239418f8eabc8637806574e6de12::blt {
    struct BLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLT>(arg0, 6, b"Blt", b"Blight", x"4120506f7461746f20546f2052656d656d62657220746865204d696c6c696f6e732074686174204469656420496e2074686520426c6967687420506f7461746f2046616d696e652e0a546865c2a04972697368c2a0506f7461746fc2a046616d696e652c6f63637572726564c2a06265747765656ec2a031383435c2a0616e64c2a0313835322ec2a04974c2a0776173c2a0636175736564c2a06279c2a061c2a0706f7461746fc2a064697365617365c2a063616c6c6564c2a06c617465c2a0626c696768742e2041626f7574c2a06f6e65c2a06d696c6c696f6ec2a070656f706c65c2a064696564c2a066726f6dc2a073746172766174696f6ec2a0616e642072656c617465642064697365617365732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732555187788.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

