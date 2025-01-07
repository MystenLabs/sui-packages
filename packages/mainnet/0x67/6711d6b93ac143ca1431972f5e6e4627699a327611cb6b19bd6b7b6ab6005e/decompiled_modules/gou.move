module 0x676711d6b93ac143ca1431972f5e6e4627699a327611cb6b19bd6b7b6ab6005e::gou {
    struct GOU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GOU>, arg1: 0x2::coin::Coin<GOU>) {
        0x2::coin::burn<GOU>(arg0, arg1);
    }

    fun init(arg0: GOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOU>(arg0, 9, b"GOU", b"GOU BABY NEIRO", b"GOU BABY NEIRO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmdz6xTDBQthMK1hhs13WNigoKPrzCbBEgRFvduC3K2kZn")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOU>(&mut v2, 25000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOU>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GOU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GOU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

