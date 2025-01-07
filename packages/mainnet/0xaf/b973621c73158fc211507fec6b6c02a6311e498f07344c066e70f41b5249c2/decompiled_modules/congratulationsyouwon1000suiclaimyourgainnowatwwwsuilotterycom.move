module 0xafb973621c73158fc211507fec6b6c02a6311e498f07344c066e70f41b5249c2::congratulationsyouwon1000suiclaimyourgainnowatwwwsuilotterycom {
    struct CONGRATULATIONSYOUWON1000SUICLAIMYOURGAINNOWATWWWSUILOTTERYCOM has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CONGRATULATIONSYOUWON1000SUICLAIMYOURGAINNOWATWWWSUILOTTERYCOM>, arg1: 0x2::coin::Coin<CONGRATULATIONSYOUWON1000SUICLAIMYOURGAINNOWATWWWSUILOTTERYCOM>) {
        0x2::coin::burn<CONGRATULATIONSYOUWON1000SUICLAIMYOURGAINNOWATWWWSUILOTTERYCOM>(arg0, arg1);
    }

    fun init(arg0: CONGRATULATIONSYOUWON1000SUICLAIMYOURGAINNOWATWWWSUILOTTERYCOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONGRATULATIONSYOUWON1000SUICLAIMYOURGAINNOWATWWWSUILOTTERYCOM>(arg0, 9, b"congratulations! you won 1000 sui ! claim your gain now at: www.sui-lottery.com", b"won", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/EHwA3Du.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CONGRATULATIONSYOUWON1000SUICLAIMYOURGAINNOWATWWWSUILOTTERYCOM>>(v1);
        0x2::coin::mint_and_transfer<CONGRATULATIONSYOUWON1000SUICLAIMYOURGAINNOWATWWWSUILOTTERYCOM>(&mut v2, 210000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CONGRATULATIONSYOUWON1000SUICLAIMYOURGAINNOWATWWWSUILOTTERYCOM>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CONGRATULATIONSYOUWON1000SUICLAIMYOURGAINNOWATWWWSUILOTTERYCOM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CONGRATULATIONSYOUWON1000SUICLAIMYOURGAINNOWATWWWSUILOTTERYCOM>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

