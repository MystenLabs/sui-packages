module 0x804082af70c864d3b51447e241e25c557a2f04b70c77caf683bd5561c6e6e224::mmit {
    struct MMIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMIT>(arg0, 6, b"MMIT", b"Mango Man Intelligent", b"This coin is for  crypto beginners who wanna explore cryptoversee! Also for all those who wanna start a fresh!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mango_a6113d1f6d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

