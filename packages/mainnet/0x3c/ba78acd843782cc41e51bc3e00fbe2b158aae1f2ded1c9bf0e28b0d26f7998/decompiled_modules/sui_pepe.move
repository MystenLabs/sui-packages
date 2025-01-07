module 0x3cba78acd843782cc41e51bc3e00fbe2b158aae1f2ded1c9bf0e28b0d26f7998::sui_pepe {
    struct SUI_PEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_PEPE>(arg0, 6, b"Sui Pepe", b"SPEPE", b"Sui Pepe is a meme token on the Sui blockchain, inspired by the Pepe meme. It offers a fun, community-driven experience with fast transactions and low fees.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1843297058612244480/vBv3kuNy.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_PEPE>(&mut v2, 444000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_PEPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_PEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

