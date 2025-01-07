module 0xb9757c314fcd9ab92138eab0515668c964408f6af1a5d1a82a25d15487ffaca7::focai {
    struct FOCAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOCAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOCAI>(arg0, 9, b"Focai", b"focai.fun", x"54686520666972737420696d6d6f7274616c2c20756e6b696c6c61626c65206f6e2d636861696e204149206167656e7420617065e28094697473206177616b656e696e67206973206272696e67696e672074686520756e6b6e6f776e20746f2074686520776f726c642e20706f776572656420627920666f63456c697a612e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWRS5h5smVBZto3ouQXB88Rw3BWQckpcUCA7stQ3VEvqW")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FOCAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOCAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOCAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

