module 0x93187c9add903984480453ce33bc334962ed0325958eb42239a919e57b413b82::primary {
    struct PRIMARY has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<PRIMARY>, arg1: 0x2::coin::Coin<PRIMARY>) {
        0x2::coin::burn<PRIMARY>(arg0, arg1);
    }

    public fun generate(arg0: &mut 0x2::coin::TreasuryCap<PRIMARY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PRIMARY> {
        0x2::coin::mint<PRIMARY>(arg0, arg1, arg2)
    }

    public entry fun generate_to(arg0: &mut 0x2::coin::TreasuryCap<PRIMARY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PRIMARY>>(0x2::coin::mint<PRIMARY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PRIMARY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIMARY>(arg0, 9, b"veHAEDAL", b"Haedal Protocol", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-GvnSd7WSoh.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PRIMARY>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRIMARY>>(v1);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

