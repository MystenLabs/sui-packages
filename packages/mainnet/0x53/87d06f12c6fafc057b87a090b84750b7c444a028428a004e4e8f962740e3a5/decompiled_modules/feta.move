module 0x5387d06f12c6fafc057b87a090b84750b7c444a028428a004e4e8f962740e3a5::feta {
    struct FETA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FETA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FETA>(arg0, 6, b"FETA", b"Sui Feta", x"4665746120436f696e206272696e67732068756d6f7220616e642061206368656573792074776973740a746f20746865206f6674656e2073747265737366756c20776f726c64206f660a63727970746f63757272656e63792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014479_3de3669d81.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FETA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FETA>>(v1);
    }

    // decompiled from Move bytecode v6
}

