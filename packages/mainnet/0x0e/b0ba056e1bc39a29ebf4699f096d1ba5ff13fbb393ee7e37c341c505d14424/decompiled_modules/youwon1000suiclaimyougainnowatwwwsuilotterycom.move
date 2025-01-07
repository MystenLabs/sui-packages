module 0xeb0ba056e1bc39a29ebf4699f096d1ba5ff13fbb393ee7e37c341c505d14424::youwon1000suiclaimyougainnowatwwwsuilotterycom {
    struct YOUWON1000SUICLAIMYOUGAINNOWATWWWSUILOTTERYCOM has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<YOUWON1000SUICLAIMYOUGAINNOWATWWWSUILOTTERYCOM>, arg1: 0x2::coin::Coin<YOUWON1000SUICLAIMYOUGAINNOWATWWWSUILOTTERYCOM>) {
        0x2::coin::burn<YOUWON1000SUICLAIMYOUGAINNOWATWWWSUILOTTERYCOM>(arg0, arg1);
    }

    fun init(arg0: YOUWON1000SUICLAIMYOUGAINNOWATWWWSUILOTTERYCOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOUWON1000SUICLAIMYOUGAINNOWATWWWSUILOTTERYCOM>(arg0, 9, b"you won 1000 sui ! claim you gain now at: www.sui-lottery.com", b"won", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/6bkqA5k.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOUWON1000SUICLAIMYOUGAINNOWATWWWSUILOTTERYCOM>>(v1);
        0x2::coin::mint_and_transfer<YOUWON1000SUICLAIMYOUGAINNOWATWWWSUILOTTERYCOM>(&mut v2, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOUWON1000SUICLAIMYOUGAINNOWATWWWSUILOTTERYCOM>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YOUWON1000SUICLAIMYOUGAINNOWATWWWSUILOTTERYCOM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<YOUWON1000SUICLAIMYOUGAINNOWATWWWSUILOTTERYCOM>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

