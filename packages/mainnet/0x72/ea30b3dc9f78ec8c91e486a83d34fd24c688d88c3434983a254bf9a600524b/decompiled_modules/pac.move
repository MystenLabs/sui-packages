module 0x72ea30b3dc9f78ec8c91e486a83d34fd24c688d88c3434983a254bf9a600524b::pac {
    struct PAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAC>(arg0, 9, b"PAC", b"America Pac SUI", b"America PAC was created to support these key values: Secure Borders, Safe Cities, Sensible spending, Fair Justice System, Free Speech", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x4c44a8b7823b80161eb5e6d80c014024752607f2.png?size=lg&key=8c3fb2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PAC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

