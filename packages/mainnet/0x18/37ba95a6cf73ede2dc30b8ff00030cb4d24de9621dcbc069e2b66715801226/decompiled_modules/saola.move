module 0x1837ba95a6cf73ede2dc30b8ff00030cb4d24de9621dcbc069e2b66715801226::saola {
    struct SAOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAOLA>(arg0, 9, b"SAOLA", b"Sao La", x"5468652073616f6c61202850736575646f727978206e67686574696e68656e736973292c20616c736f2063616c6c6564207370696e646c65686f726e2c20417369616e20756e69636f726e2c2056c5a9205175616e6720626f7669642c206973206f6e65206f662074686520776f726c64e280997320726172657374206c61726765206d616d6d616c732c206120666f726573742d6477656c6c696e6720626f76696e65206e617469766520746f2074686520416e6e616d6974652052616e676520696e20566965746e616d20616e64204c616f732e202453414f4c41206973206173736574206f662053616f6c612046756e642050726f6a6563742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4ef0224f-b8b3-4d60-965a-5cc626b9e048.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

