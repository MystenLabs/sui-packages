module 0xf28368d16a261cec7f3969828f18c462afd3802475849a8a6589fd0f1ff4c84e::caat {
    struct CAAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAAT>(arg0, 6, b"CAAT", b"Im Sui Cat", x"41207369676e69666963616e74206576656e742068617320756e666f6c64656420696e2032303234202d2024434141540a2d204361742053756921200a0a224a6f696e207468652053756920776974682024434141543a20596f75722046656c696e6520416c6c7920696e207468650a466967687420666f7220446563656e7472616c697a6174696f6e22", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CAAT_apt_7aa5a8bbb5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

