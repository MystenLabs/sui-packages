module 0xc34746b1ec5d5e34e95b4ffc065f042e4ff9f6d890548a8d610d20dfadd237a::copium {
    struct COPIUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: COPIUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COPIUM>(arg0, 6, b"COPIUM", b"Copium On Sui", x"24434f5049554d20206675656c20666f722062656c696576696e6720696e206265747465722064617973207768656e20746865206d61726b65742073617973206f74686572776973652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001325_e55674dce4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COPIUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COPIUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

