module 0xfc2f471a0217a4dfc1f952a7cbfb298a19486ec9c64b30a9c0471f217152c48b::cr7 {
    struct CR7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CR7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CR7>(arg0, 6, b"CR7", b"CR7 COIN ON SUI", x"4a6f696e207573206265666f72652024435237206c65616473207468652046616e20746f6b656e7320736561736f6e210a547769747465723a202068747470733a2f2f782e636f6d2f6372376f6e7375690a54473a68747470733a2f2f742e6d652f6372376f6e737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo1_c3e5a4ad6a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CR7>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CR7>>(v1);
    }

    // decompiled from Move bytecode v6
}

