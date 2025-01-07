module 0xfd7cde7d3a1c62ae1eeef9c1877304ec1c6bf72730c79ea5fae34d2940fd3a6c::maxi {
    struct MAXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAXI>(arg0, 9, b"MAXI", b"Maxi", x"4d41584920697320746865206c6f7661626c65206d6173636f74206f6620746865204d6f7869652065636f73797374656d20616e64207468652063727970746f63757272656e637920746861742068656c707320796f7520e2809c6d6178692d6d697a65e2809d20796f75722063727970746f20706f74656e7469616c21204275696c74206f6e2074686520537569206e6574776f726b2c20616e20457468657265756d204c61796572203220736f6c7574696f6e2c204d415849206f666665727320717569636b207472616e73616374696f6e7320616e64206d696e696d616c2067617320666565732c206b656570696e6720796f75722077616c6c65742068617070792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x080c169cd58122f8e1d36713bf8bcbca45176905.png?size=xl&key=d43e98")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAXI>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAXI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAXI>>(v1);
    }

    // decompiled from Move bytecode v6
}

