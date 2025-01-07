module 0x2bab6c65072b9d3940af12b17ae03b9d56483b6ac0000a7b10afd8019483c0a8::blacklama {
    struct BLACKLAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACKLAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACKLAMA>(arg0, 9, b"BLACKLAMA", b"BLackLama", x"e2809c4a6f696e207468652066756e207769746820426c61636b4c616d61204d656d65636f696e21205468697320706c617966756c2063727970746f63757272656e637920626c656e64732068756d6f7220616e6420636f6d6d756e697479207370697269742c20696e766974696e672065766572796f6e6520746f206578706c6f726520746865206578636974696e6720776f726c64206f662063727970746f20746f6765746865722e20456d627261636520746865206d656d65732c20656e6761676520776974682066656c6c6f7720656e7468757369617374732c20616e642072696465207468652077617665206f6620696e6e6f766174696f6e21e2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/090a6889-b27c-49a6-a37c-17bc3f38e64b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKLAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLACKLAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

