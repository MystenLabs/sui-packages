module 0xad3c889f101ae4d999ce3e515466d1ec0968d4f5a6982e99e485a2383e87afd4::sle {
    struct SLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLE>(arg0, 9, b"SLE", b"slee", x"476c69646520696e746f207765616c7468207769746820536c6565436f696e3a2054686520647265616d792063727970746f63757272656e637920746861742773206472696674696e67207468726f75676820746865206d61726b6574207769746820706561636566756c2070726f6669747320616e64206c756c6c696e6720796f757220706f7274666f6c696f20696e746f206120736572656e65207374617465206f6620737563636573732120f09f8c99f09f92b0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d93cf8bb-de3a-4aea-a862-1058bb02e37e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

