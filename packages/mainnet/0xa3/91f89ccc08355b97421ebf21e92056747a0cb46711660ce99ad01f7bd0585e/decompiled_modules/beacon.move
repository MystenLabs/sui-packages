module 0xa391f89ccc08355b97421ebf21e92056747a0cb46711660ce99ad01f7bd0585e::beacon {
    struct BEACON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEACON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEACON>(arg0, 9, b"BEACON", b"Beacongam", x"57656c636f6d6520746f2054686520426561636f6e0a0a4772656574696e67732c20627261766520616476656e7475726572212041726520796f7520707265706172656420746f20636f6e66726f6e74207468652064616e67657273206c75726b696e6720696e2074686520646570746873206f66207468652064756e67656f6e733f20e29a94efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0e63ec4b-87a6-4be9-870f-b2cc5cbd1dbb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEACON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEACON>>(v1);
    }

    // decompiled from Move bytecode v6
}

