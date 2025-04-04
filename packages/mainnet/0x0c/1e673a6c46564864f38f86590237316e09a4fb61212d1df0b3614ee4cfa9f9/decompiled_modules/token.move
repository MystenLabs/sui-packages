module 0xc1e673a6c46564864f38f86590237316e09a4fb61212d1df0b3614ee4cfa9f9::token {
    struct MyToken has key {
        id: 0x2::object::UID,
        total_supply: u64,
        name: vector<u8>,
        symbol: vector<u8>,
        description: vector<u8>,
        image_url: 0x2::url::Url,
    }

    struct TOKEN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOKEN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TOKEN> {
        0x2::coin::mint<TOKEN>(arg0, arg1, arg2)
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::url::new_unsafe_from_bytes(b"https://red-rainy-catfish-636.mypinata.cloud/ipfs/QmfF9erhWqxTqrMjeX5w9NtqqLdh7bkKxeBFKGSHDeNudY");
        let v1 = MyToken{
            id           : 0x2::object::new(arg1),
            total_supply : 0,
            name         : b"My Awesome Token",
            symbol       : b"MAT",
            description  : b"This is my awesome token for trading",
            image_url    : v0,
        };
        let (v2, v3) = 0x2::coin::create_currency<TOKEN>(arg0, 9, b"MAT", b"My Awesome Token", b"This is my awesome token for trading", 0x1::option::some<0x2::url::Url>(v0), arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v3);
        let v5 = 1000000000000000;
        let v6 = &mut v4;
        let v7 = mint(v6, v5, arg1);
        v1.total_supply = v5;
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<MyToken>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN>>(v7, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

