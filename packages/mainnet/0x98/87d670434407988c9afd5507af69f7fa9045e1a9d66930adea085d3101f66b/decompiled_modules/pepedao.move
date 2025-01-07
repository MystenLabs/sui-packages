module 0x9887d670434407988c9afd5507af69f7fa9045e1a9d66930adea085d3101f66b::pepedao {
    struct PEPEDAO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PEPEDAO>, arg1: 0x2::coin::Coin<PEPEDAO>) {
        0x2::coin::burn<PEPEDAO>(arg0, arg1);
    }

    fun init(arg0: PEPEDAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEDAO>(arg0, 9, b"PEPEDAO", b"PEPE DAO", b"Pepe Dao Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1683401789338-b5e9b4f86ce43ca65bd79c894c4a924c.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPEDAO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEDAO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPEDAO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PEPEDAO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

