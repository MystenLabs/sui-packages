module 0x435133725bfcb28994e69134d3529574f65abd146dc0ba8a4c44574db8e68343::vtai {
    struct VTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VTAI>(arg0, 6, b"VTAI", b"Void Terminal AI", x"52652d6c61756e6368204e6577205469636b65722024565441490a0a566f6964205465726d696e616c20414920697320616e20414920706f7765726564207465726d696e616c2064657369676e656420666f722073696d706c6520696e746572616374696f6e732077697468205465726d696e616c436861742e20566f6964205465726d696e616c20414920656e737572657320707269766174652c207365637572652c20616e642072656c6961626c6520636f6d6d756e69636174696f6e2c206d616b696e6720697420696465616c20666f7220576562332050726f6a6563742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/void_17f9183f82.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

