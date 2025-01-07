module 0xe04cb1ae724f1053ddc82a65f8cde7dba1747cf1eb4a35fa0339de3eb75932af::dore {
    struct DORE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORE>(arg0, 9, b"DORE", b"Doraemon", x"f09f9a8020446f7265436f696e20e280932041206d656d6520636f696e206f6e2053554920696e73706972656420627920446f7261656d6f6e20f09f90b10a4272696e67696e672070726f74656374696f6e20616e642073746162696c6974792c20446f7265436f696e206b6565707320696e766573746f727320736166652066726f6d206d61726b657420766f6c6174696c6974792e204a6f696e206e6f7720616e64206665656c207365637572652120f09f9490", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/058a78dd-2947-4444-943d-c7efa1e14aa2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DORE>>(v1);
    }

    // decompiled from Move bytecode v6
}

