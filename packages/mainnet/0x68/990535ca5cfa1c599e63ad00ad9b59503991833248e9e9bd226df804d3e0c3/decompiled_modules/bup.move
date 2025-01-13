module 0x68990535ca5cfa1c599e63ad00ad9b59503991833248e9e9bd226df804d3e0c3::bup {
    struct BUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUP>(arg0, 6, b"BUP", b"BURP", b"Because holding it in was never an option", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/l_Iy_Borzh_400x400_2ca37c5694.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

