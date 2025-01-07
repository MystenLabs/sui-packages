module 0x898b5f81ba6f203234a62710212d7d1de4b358cdf74aaa17c4fbd016266cfb0e::monsters {
    struct MONSTERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONSTERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONSTERS>(arg0, 6, b"MONSTERS", b"BUBBLEMONSTERS", x"436f6e65206a6f696e20627562626c65206d6f6e737465727320616e64206c6574732067726f77206173206120636f6d6d756e697479200a0a576861742063616e20796f75206578706563743a0a5570636f6d696e6720636f6c6c656374696f6e206f66204e465420627562626c65206d6f6e73746572730a476f6f64206d61726b6574696e672073747261746567696573200a46756e20636f6d6d756e69747920616e64206461696c79206d656d65730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731024615982.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONSTERS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONSTERS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

