module 0x666e8d85e5b4db9fc97a7bafb16c8fa5de60b04cae3bee8d2969d88ec98a24db::ssf {
    struct SSF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSF>(arg0, 6, b"SSF", b"Sui sea fisfh", b"A fish live in deep sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cangua_f8d726c689.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSF>>(v1);
    }

    // decompiled from Move bytecode v6
}

