module 0xd7ff5371865a52cf3e8c528f0e4b9d9a5a05c32af42d0b1b298592647485bb13::boots {
    struct BOOTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOTS>(arg0, 6, b"BOOTS", b"BOOTSUI", x"424f4f54535549202d20467574757265204b696e67206f6620535549204d656d65636f696e73210a4261736564206f6e204465762773204361742e20436f6d706c6574656c79206f726967696e616c20746f6b656e2e20424f4f545355492e204c464721210a5765627369746520636f6d696e6720736f6f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BOOTSUI_bae47d2e3d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

