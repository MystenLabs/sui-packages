module 0xa727d4dc21cda064f2edeeb221b1fef559a0fe5c4fae5767f7476527be0042c::casuino {
    struct CASUINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASUINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASUINO>(arg0, 6, b"Casuino", b"Casuino on Sui", x"546865206f6e6c79202443617375696e6f20746861742077696c6c206d616b65207520726963680a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_5_d12545d5d2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASUINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CASUINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

