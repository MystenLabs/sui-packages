module 0x1c06aa38bbbd9cde25c8e98419ef1fae6df02b504fb7dc56530f69e7781b9cc1::mon {
    struct MON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MON>(arg0, 9, b"MON", b"mons", x"436f6e71756572207468652063727970746f207265616c6d2077697468204d6f6e73436f696e3a20546865206d69676874792063727970746f63757272656e637920746861742773206d6f6e737465722d73697a656420696e2070726f6669747320616e642074616b696e6720746865206d61726b65742062792073746f726d2077697468206c6567656e64617279206761696e732120f09f9089", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/539e66fc-6cf8-4668-9b5a-188f010a2221.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MON>>(v1);
    }

    // decompiled from Move bytecode v6
}

