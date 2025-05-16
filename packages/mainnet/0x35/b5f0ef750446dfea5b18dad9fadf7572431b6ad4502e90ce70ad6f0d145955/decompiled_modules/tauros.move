module 0x35b5f0ef750446dfea5b18dad9fadf7572431b6ad4502e90ce70ad6f0d145955::tauros {
    struct TAUROS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAUROS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAUROS>(arg0, 6, b"Tauros", b"Taursui", x"546175726f73206f6e2073756920426c6f636b636861696e200a43617463682074686520656e657267792e205269646520746865206368617267652e204265207468652062756c6c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreici6vepar2vyhl4indtj2qt722t3akogcfwjeysyhu5yo63mlneg4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAUROS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TAUROS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

