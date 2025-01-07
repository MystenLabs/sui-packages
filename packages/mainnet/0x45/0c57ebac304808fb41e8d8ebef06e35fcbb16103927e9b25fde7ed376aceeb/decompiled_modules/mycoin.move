module 0x450c57ebac304808fb41e8d8ebef06e35fcbb16103927e9b25fde7ed376aceeb::mycoin {
    struct MYCOIN has drop {
        dummy_field: bool,
    }

    struct CreatorInfo has key {
        id: 0x2::object::UID,
        address: address,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MYCOIN>, arg1: 0x2::coin::Coin<MYCOIN>) {
        0x2::coin::burn<MYCOIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MYCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MYCOIN>>(0x2::coin::mint<MYCOIN>(arg0, arg1, arg3), arg2);
    }

    public entry fun transfer(arg0: &mut 0x2::coin::Coin<MYCOIN>, arg1: u64, arg2: address, arg3: &CreatorInfo, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1 / 100;
        0x2::transfer::public_transfer<0x2::coin::Coin<MYCOIN>>(0x2::coin::split<MYCOIN>(arg0, v0, arg4), arg3.address);
        0x2::transfer::public_transfer<0x2::coin::Coin<MYCOIN>>(0x2::coin::split<MYCOIN>(arg0, arg1 - v0, arg4), arg2);
    }

    fun init(arg0: MYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYCOIN>(arg0, 9, b"MYCOIN123", b"My Coin123", x"e8bf99e698afe4b880e4b8aae7a4bae4be8be4bba3e5b881313233", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.iconaves.com/token_icon/eth/0xdac17f958d2ee523a2206206994597c13d831ec7.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MYCOIN>>(0x2::coin::mint<MYCOIN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        let v3 = CreatorInfo{
            id      : 0x2::object::new(arg1),
            address : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<CreatorInfo>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYCOIN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MYCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

