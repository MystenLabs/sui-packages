module 0x41abdf1546d438bafa303fa5aa811f056319e4f5c2ae18f0cda6357e5ff464ac::feta {
    struct FETA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FETA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FETA>(arg0, 6, b"FETA", b"Sui Feta", x"4665746120436f696e206272696e67732068756d6f7220616e642061206368656573792074776973740a746f20746865206f6674656e2073747265737366756c20776f726c64206f660a63727970746f63757272656e63792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014479_1a69dccd06.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FETA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FETA>>(v1);
    }

    // decompiled from Move bytecode v6
}

