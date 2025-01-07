module 0xa3c73f050599c4b71e652659b548bf352ae76afab28087853842a95a3d715dfb::trumpina {
    struct TRUMPINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPINA>(arg0, 6, b"TRUMPINA", b"The Trumpina Tor", b"The Trumpina Tor - Came with me if you want to moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1735868653348_baced0937e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPINA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPINA>>(v1);
    }

    // decompiled from Move bytecode v6
}

