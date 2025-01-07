module 0x72f6fd0aba740e4b900c69ba675b724a713f0a95ddf4738b2e7b5c4b14472e06::PEEP {
    struct PEEP has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PEEP>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PEEP>>(0x2::coin::mint<PEEP>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: PEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEEP>(arg0, 9, b"PEEP", b"PEEP", b"$PEEP and the #peepoarmy will one day buy a juice box for 69 peeps", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1654077532227117056/0BC7gA3N_400x400.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEEP>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEEP>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEEP>>(v1, 0x2::tx_context::sender(arg1));
    }

    entry fun renounce_owner(arg0: &mut 0x2::coin::TreasuryCap<PEEP>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PEEP>>(0x2::coin::mint<PEEP>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

