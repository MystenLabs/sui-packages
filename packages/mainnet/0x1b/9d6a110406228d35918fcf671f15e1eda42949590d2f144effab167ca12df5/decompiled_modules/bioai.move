module 0x1b9d6a110406228d35918fcf671f15e1eda42949590d2f144effab167ca12df5::bioai {
    struct BIOAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIOAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIOAI>(arg0, 6, b"BioAI", b"BioAI", b"$BioAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/solana/CgrxHFHdCSNX9SyJSa4Trp3vRW9NHTGQVx2RK5Kxw1HU.png?size=lg&key=9cb03c"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIOAI>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BIOAI>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIOAI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

