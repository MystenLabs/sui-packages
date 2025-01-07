module 0xc745ff88a244d4df284c5a7d0967ca70ba6afa460ddcc45f159f3f44a379515a::dawge {
    struct DAWGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAWGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAWGE>(arg0, 6, b"DAWGE", b"Dawgee", x"496e74726f647563696e672044617767656520436f696e202844415747452920207468652061646f7261626c7920697272657369737469626c6520746f6b656e20696e7370697265642062792074686520707572652c20756e66696c7465726564206a6f79206f662061206368696c6473206172742120546869732069736e74206a7573742061206d656d653b206974732061206d6f76656d656e74206675656c656420627920746865207761726d7468206f66206269672d6579656420646f676779206c6f7665210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3279_3454c748a6.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAWGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAWGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

