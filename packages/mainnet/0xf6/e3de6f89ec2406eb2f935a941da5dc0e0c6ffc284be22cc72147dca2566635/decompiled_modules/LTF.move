module 0xf6e3de6f89ec2406eb2f935a941da5dc0e0c6ffc284be22cc72147dca2566635::LTF {
    struct LTF has drop {
        dummy_field: bool,
    }

    fun init(arg0: LTF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LTF>(arg0, 6, b"LTF", b"low taper fade", b"imagine if ninja got a low taper fade...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmPHkSfrTLcNiaYgWuP4afQZeUvZjj7gg75Vovg4TrnStk")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LTF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LTF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

