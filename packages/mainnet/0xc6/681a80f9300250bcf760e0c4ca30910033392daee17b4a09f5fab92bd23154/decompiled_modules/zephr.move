module 0xc6681a80f9300250bcf760e0c4ca30910033392daee17b4a09f5fab92bd23154::zephr {
    struct MyZephr has key {
        id: 0x2::object::UID,
        max_supply: u64,
        total_supply: u64,
        name: vector<u8>,
        symbol: vector<u8>,
        description: vector<u8>,
        image_url: 0x2::url::Url,
    }

    struct ZEPHR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEPHR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::url::new_unsafe_from_bytes(b"https://red-rainy-catfish-636.mypinata.cloud/ipfs/QmQZyrsTMCDJSRhueXoYMTWndp3cp8H2Lrj6KZvq48LdPh");
        let v1 = MyZephr{
            id           : 0x2::object::new(arg1),
            max_supply   : 10000000000000,
            total_supply : 10000000000000,
            name         : b"ZEPHR",
            symbol       : b"ZEPHR",
            description  : b"This is my awesome ZEPHR",
            image_url    : v0,
        };
        let (v2, v3) = 0x2::coin::create_currency<ZEPHR>(arg0, 9, b"ZEPHR", b"My Awesome ZEPHR", b"This is my awesome ZEPHR", 0x1::option::some<0x2::url::Url>(v0), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZEPHR>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEPHR>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<MyZephr>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

