module 0x8eb3cecc145f546b9162012499402cf1c8eb03b06a7a87023f6110663acd8443::holy_cow {
    struct HOLY_COW has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<HOLY_COW>, arg1: 0x2::coin::Coin<HOLY_COW>) {
        0x2::coin::burn<HOLY_COW>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<HOLY_COW>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HOLY_COW>>(0x2::coin::mint<HOLY_COW>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: HOLY_COW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLY_COW>(arg0, 9, b"HOLYCOW", b"Holy Cow Coin", b"A standard fungible coin of the holycow ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://salmon-accused-puma-149.mypinata.cloud/ipfs/bafkreib4vyuqsp7rzzn7cu23fyzwxkg4ngeg6bdkmecsfz4xdzahxclksy?pinataGatewayToken=Nc4R8TH9sXtjJQUiqvn_ZXvRnNYOlp6eH8lT7JTr0zEUEZV2BjEMU-81HiF2dy5x")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<HOLY_COW>>(0x2::coin::mint<HOLY_COW>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOLY_COW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLY_COW>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

