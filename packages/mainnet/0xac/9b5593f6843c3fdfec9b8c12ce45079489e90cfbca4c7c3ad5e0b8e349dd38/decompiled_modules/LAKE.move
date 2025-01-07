module 0xac9b5593f6843c3fdfec9b8c12ce45079489e90cfbca4c7c3ad5e0b8e349dd38::LAKE {
    struct LAKE has drop {
        dummy_field: bool,
    }

    struct TokenMetadata has store, key {
        id: 0x2::object::UID,
        symbol: vector<u8>,
        name: vector<u8>,
        image: 0x2::url::Url,
        website: 0x2::url::Url,
        twitter: 0x2::url::Url,
    }

    fun init(arg0: LAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/qkUXlL6.jpg"));
        let (v1, v2) = 0x2::coin::create_currency<LAKE>(arg0, 9, b"LAKE", b"SUI LAKE", b"SUI is literally a lake", 0x1::option::some<0x2::url::Url>(v0), arg1);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<LAKE>>(0x2::coin::mint<LAKE>(&mut v3, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAKE>>(v2);
        let v4 = TokenMetadata{
            id      : 0x2::object::new(arg1),
            symbol  : b"LAKE",
            name    : b"SUI LAKE",
            image   : v0,
            website : 0x2::url::new_unsafe(0x1::ascii::string(b"https://lake.io")),
            twitter : 0x2::url::new_unsafe(0x1::ascii::string(b"https://twitter.com/lakesui")),
        };
        0x2::transfer::public_transfer<TokenMetadata>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAKE>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

