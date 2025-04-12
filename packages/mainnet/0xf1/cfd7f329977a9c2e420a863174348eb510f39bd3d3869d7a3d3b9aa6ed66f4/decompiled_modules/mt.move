module 0xf1cfd7f329977a9c2e420a863174348eb510f39bd3d3869d7a3d3b9aa6ed66f4::mt {
    struct MT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MT>(arg0, 9, b"MT", b"MTX", x"6f6666696369616c207374617274656420666972737420726f756e6420c2a9efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/09bef24196b20aab51a8455dfa46597eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

