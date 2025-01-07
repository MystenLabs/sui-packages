module 0xe79c230cba96dd13065ac60a7bca83c8de964db4845e1d9e72a580bc3382fb33::hoppui {
    struct HOPPUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPPUI>(arg0, 6, b"HOPPUI", b"HOPPY ON SUI", x"496e74726f647563696e672024486f70707569200a546865206d656d65636f696e207468617473206272696e67696e67207468652072696262697420746f207468652053756920626c6f636b636861696e21200a4661737420686f7073200a54696e79206761732066656573200a426967206d656d6520656e65726779200a24486f707075692069736e74206a757374206120636f696e206974732061206d6f76656d656e742e20486f7020696e206265666f7265207765206c65617020746f20746865206d6f6f6e2120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hoppy_sui_logo_6f84c1f385.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPPUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPPUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

