module 0x767a4f17fd9d1c6d43d0a8955b9b87911d2455137265c5e9ae10aff88ed58c9e::rby {
    struct RBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RBY>(arg0, 9, b"RBY", b"rabby", x"486f7020696e746f20746865206675747572652077697468205261626279436f696e3a205468652063727970746f20746861742773206d756c7469706c79696e67206c696b6520726162626974732c2064656c69766572696e6720686172652d72616973696e672070726f6669747320616e6420686f7070696e6720676f6f642074696d65732120f09f90b0f09f92b8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2c93c2fc-95ee-4ad3-96d4-751973563b0c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

