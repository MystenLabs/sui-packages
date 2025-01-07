module 0xe034fc44451b41797783a960f0866712b0b79b92fb215b10d2ad367a3b259895::carl {
    struct CARL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARL>(arg0, 6, b"Carl", b"Carl the Hedgehog", x"244341524c206a75737420746f756368656420677261737320616e6420696d6d6564696174656c79207265677265747465642069742e0a546f6f206d616e7920627567732c20746f6f206d7563682073756e2e2054616b65206d65206261636b20746f206265642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055002_77bcfb0400.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARL>>(v1);
    }

    // decompiled from Move bytecode v6
}

