module 0x8842f68767fb844a04a42c9958bc98264418ac43ed716f6f320964eb8d6cf5ff::todd {
    struct TODD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TODD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TODD>(arg0, 6, b"TODD", b"TODD", b"KING AND SHUT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.google.com/url?sa=i&url=https%3A%2F%2Fru.wikipedia.org%2Fwiki%2FTODD_%2528%25D0%25B0%25D0%25BB%25D1%258C%25D0%25B1%25D0%25BE%25D0%25BC%2529&psig=AOvVaw3TGeYI3E22Egg7Wt6GqtQg&ust=1705266153867000&source=images&cd=vfe&ved=0CBIQjRxqFwoTCMje2syh24MDFQAAAAAdAAAAABAE")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TODD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TODD>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TODD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TODD>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

