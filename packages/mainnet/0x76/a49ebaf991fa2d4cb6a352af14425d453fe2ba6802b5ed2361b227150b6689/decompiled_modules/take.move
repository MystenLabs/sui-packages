module 0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take {
    struct TAKE has drop {
        dummy_field: bool,
    }

    fun create_coin(arg0: TAKE, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TAKE> {
        let (v0, v1) = 0x2::coin::create_currency<TAKE>(arg0, 9, b"TAKE", b"TAKE", b"TAKE is the utility token of OVERTAKE, used across key activities while trading on the platform. Its demand is tied to platform usage through a buyback-burn model.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/ottm-labs/overtake-content/refs/heads/main/icons/TAKE.svg")), arg2);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAKE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TAKE>>(v2);
        0x2::coin::mint<TAKE>(&mut v2, arg1, arg2)
    }

    fun init(arg0: TAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_coin(arg0, 1000000000000000000, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TAKE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

