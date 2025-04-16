module 0xc04cf425e3130f7044052dc248eeb45dab2d3f5f201ff2fd115c11c74ed79e43::itssui {
    struct ITSSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITSSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ITSSUI>(arg0, 6, b"ItsSui", b"It's SUI", x"546865206265737420626c6f636b636861696e3f204974277320535549200a546865206265737420446576733f204974277320535549200a546865206265737420636f6d6d756e6974793f204974277320535549200a436f66666565207669612074786e733f204974277320535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihgpjf5upqdfh4wgxtt47qvv5r547yjitmq5nukaxkn3ibkaifnbe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITSSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ITSSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

