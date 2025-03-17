module 0xaaf93b2cb17a6566cdb4607f7d36f221faccb937751725b18fa0df392dbdf444::iplr {
    struct IPLR has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<IPLR>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<IPLR>>(0x2::coin::mint<IPLR>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: IPLR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/EyzgnBfHGe9hh169B8993muBVcoeURCnSgPbddBeSybo.png?size=lg&key=1313e8                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<IPLR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"IPLR    ")))), trim_right(b"Infinite Price Liquidity Rocket "), trim_right(b"Professionally Done Sui Rewards token that enhances and upgrades the typical rewards token by not only providing ez passive income by auto paying $Sui to holders every 5 minutes but also constantly increases the Liquidity Pool providing a smooth increase in price and reducing Volatility.                                "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IPLR>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<IPLR>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<IPLR>>(0x2::coin::mint<IPLR>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

