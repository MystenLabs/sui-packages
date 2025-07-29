module 0xc202b778f0a0cba81bdcf2c3efd7efa1d6404590299a452d9cc59258d154e14::gor {
    struct GOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOR>(arg0, 6, b"GOR", b"Gorbagana on Sui", b"Running Gorbagana. A lore that cannot be faded. A lore into a reality, happening right in front of your eyes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeie6hydsi5ryv53tz2k2mawtggn3fkkiyaelm5ukupdohdgp652wui")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GOR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

