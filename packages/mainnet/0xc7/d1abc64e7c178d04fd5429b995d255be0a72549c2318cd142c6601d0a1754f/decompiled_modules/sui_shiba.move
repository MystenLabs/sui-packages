module 0xc7d1abc64e7c178d04fd5429b995d255be0a72549c2318cd142c6601d0a1754f::sui_shiba {
    struct SUI_SHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_SHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_SHIBA>(arg0, 9, b"Sui Shiba", b"Sui Shiba", b"Sui Shiba Sui Shiba", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.purina.ru/sites/default/files/2021-02/BREED%20Hero_0075_japanese_shiba_inu.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_SHIBA>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_SHIBA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_SHIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

