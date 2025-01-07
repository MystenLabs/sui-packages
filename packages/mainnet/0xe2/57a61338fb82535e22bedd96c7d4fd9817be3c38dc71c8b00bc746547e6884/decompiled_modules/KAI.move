module 0xe257a61338fb82535e22bedd96c7d4fd9817be3c38dc71c8b00bc746547e6884::KAI {
    struct KAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAI>(arg0, 9, b"KAI", b"kai.finance", b"Yield Aggregator on Sui Network. Safe and easy access to superior yields", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1724025185412513792/rKgX3p1K_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

