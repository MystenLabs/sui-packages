module 0xadfc1a9e7420c1f4947efb72f8eb51686d51df3b14c5a22e2685181f22ae52bf::lp {
    struct LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LP>(arg0, 9, b"LP", b"Livin poor", x"4c6976696e6720706f6f7220746f206f6e6520646179206d616b6520697420726963682c2074686973206973206120636f696e20666f7220616c6c2074686f73652077686f207472756c792062656c6965766520746865792077696c6c206d616b652069742c20746865792077696c6c2073616372696669636520616e64206465646963617465207468656d73656c76657320746f20646f2077686174206f7468657220776f6ee280997420", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0525401e-979d-43ea-9871-f3c88aed5989.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LP>>(v1);
    }

    // decompiled from Move bytecode v6
}

