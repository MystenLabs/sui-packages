module 0xab19a27ae9b7416fdc786a554e586de64a14297b007255956e88e057501077ef::bearmarketshelter {
    struct BEARMARKETSHELTER has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BEARMARKETSHELTER>, arg1: vector<0x2::coin::Coin<BEARMARKETSHELTER>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<BEARMARKETSHELTER>>(&mut arg1);
        0x2::pay::join_vec<BEARMARKETSHELTER>(&mut v0, arg1);
        0x2::coin::burn<BEARMARKETSHELTER>(arg0, 0x2::coin::split<BEARMARKETSHELTER>(&mut v0, arg2, arg3));
        if (0x2::coin::value<BEARMARKETSHELTER>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<BEARMARKETSHELTER>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<BEARMARKETSHELTER>(v0);
        };
    }

    fun init(arg0: BEARMARKETSHELTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<BEARMARKETSHELTER>(arg0, 9, b"BMSSui", b"BEARMARKETSHELTER", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<BEARMARKETSHELTER>(&mut v4, 100000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEARMARKETSHELTER>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEARMARKETSHELTER>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BEARMARKETSHELTER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BEARMARKETSHELTER>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<BEARMARKETSHELTER>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BEARMARKETSHELTER>>(arg0);
    }

    // decompiled from Move bytecode v6
}

