module 0x9f904a656e80eaef23e1e86b4e68d6b4d945400e55708ca9e0e4df784b5cf14f::svt {
    struct SVT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SVT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SVT>(arg0, 6, b"SVT", b"Suivault", b"Suivault - Secure your tokens with Token Lock, Vesting, Burn Token, and Burn LP  all powered by the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055116_e7b6781af1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SVT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SVT>>(v1);
    }

    // decompiled from Move bytecode v6
}

