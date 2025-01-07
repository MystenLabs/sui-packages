module 0x319f374005a6e1ec8bcf456d33cbb2fc348d376093f9c7d277ed66f7e0665a2::TOM {
    struct TOM has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOM>, arg1: 0x2::coin::Coin<TOM>) {
        0x2::coin::burn<TOM>(arg0, arg1);
    }

    fun init(arg0: TOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOM>(arg0, 2, b"TOM", b"TOM", b"TOM on the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.dextools.io/resources/tokens/logos/ether/0xb477718f329dffda6bc09b0e265acc38966536f8.jpg?1683559118481")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TOM>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

