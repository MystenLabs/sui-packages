module 0x52ce9c07d58955a5087722ffde35993237ed90513664e449c6f377e3e7373957::lon {
    struct LON has drop {
        dummy_field: bool,
    }

    fun init(arg0: LON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LON>(arg0, 9, b"LON", b"lion", x"526f617220776974682070726964652077697468204c696f6e436f696e3a20546865206b696e67206f662063727970746f63757272656e636965732c2064656c69766572696e67206d616a65737469632070726f6669747320616e642072756c696e67207468652063727970746f206a756e676c65207769746820737472656e67746820616e64206e6f62696c697479f09fa681f09f92b0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a83e66b9-6792-4d1d-b07c-0cda68653d27.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LON>>(v1);
    }

    // decompiled from Move bytecode v6
}

