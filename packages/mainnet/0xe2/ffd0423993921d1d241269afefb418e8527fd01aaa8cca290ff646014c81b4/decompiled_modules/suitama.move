module 0xe2ffd0423993921d1d241269afefb418e8527fd01aaa8cca290ff646014c81b4::suitama {
    struct Registry has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<SUITAMA>,
    }

    struct SUITAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITAMA>(arg0, 8, b"SUITAMA", b"Suitama", b"Saitama on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/cLvdNlA.png")), arg1);
        let v2 = Registry{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITAMA>>(v1);
        0x2::transfer::share_object<Registry>(v2);
    }

    public entry fun mint(arg0: &mut Registry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUITAMA>(&mut arg0.treasury_cap, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

