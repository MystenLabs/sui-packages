module 0xdd8805bec16c7aa13a013d707dbf810dc9caed970f001fa9ceb33fa37ecf4dfa::groggo {
    struct GROGGO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GROGGO>, arg1: 0x2::coin::Coin<GROGGO>) {
        0x2::coin::burn<GROGGO>(arg0, arg1);
    }

    fun init(arg0: GROGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<GROGGO>(arg0, 9, b"GROGGO", b"GROGGO", x"4d6565742047726f67676f2074686520426c75652046726f672028616b6120426c756520506570652920e2809320746865206f6e6520616e64206f6e6c7920626c75652066726f6720696e204d617474204675726965277320234675726965766572736521205468697320656c75736976652c2062696e6f63756c61722d7769656c64696e6720636861726163746572206973206e6f74206a75737420616e792066726f6720e280932068652773206120626f6c64206f726967696e616c2066726f6d204d617474204675726965e2809973204d696e64766973636f736974792c2074686520746869726420626f6f6b20696e206869732069636f6e696320736572696573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/V6rPy47D/AVA-1.webp")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<GROGGO>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GROGGO>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GROGGO>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<GROGGO>>(v1, @0xda2032e951193540becaf5f3c293b967fc5a4745e3ba5b551aa53c4db976f924);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<GROGGO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<GROGGO>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GROGGO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GROGGO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

