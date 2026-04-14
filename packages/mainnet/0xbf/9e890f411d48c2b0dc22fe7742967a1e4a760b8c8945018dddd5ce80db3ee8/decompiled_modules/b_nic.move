module 0xbf9e890f411d48c2b0dc22fe7742967a1e4a760b8c8945018dddd5ce80db3ee8::b_nic {
    struct B_NIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_NIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_NIC>(arg0, 9, b"bNIC", b"bToken NIC", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_NIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_NIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

