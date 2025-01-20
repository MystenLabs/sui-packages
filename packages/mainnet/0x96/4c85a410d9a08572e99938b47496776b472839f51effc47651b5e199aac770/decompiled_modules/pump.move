module 0x964c85a410d9a08572e99938b47496776b472839f51effc47651b5e199aac770::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PUMP>, arg1: 0x2::coin::Coin<PUMP>) {
        0x2::coin::burn<PUMP>(arg0, arg1);
    }

    fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<PUMP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PUMP>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"When everyone was treading water, there he came..... Trump! Or should I say Donald Pump. And now the market isn't just breathing - it's screaming, pamping and going to the moon. 1B MC? That's like morning coffee for him. Donald Pump doesn't play dirty                                                                     ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PUMP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PUMP      ")))), trim_right(b"Donald Pump                     "), trim_right(x"5768656e2065766572796f6e6520776173207472656164696e672077617465722c2074686572652068652063616d652e2e2e2e2e205472756d7021204f722073686f756c6420492073617920446f6e616c642050756d702e20416e64206e6f7720746865206d61726b65742069736e2774206a75737420627265617468696e67202d20697427732073637265616d696e672c2070616d70696e6720616e6420676f696e6720746f20746865206d6f6f6e2e203142204d433f20546861742773206c696b65206d6f726e696e6720636f6666656520666f722068696d2e20446f6e616c642050756d7020646f65736e277420706c61792064697274790a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        let v5 = v3;
        let v6 = &mut v5;
        let v7 = 0x2::tx_context::sender(arg1);
        mint_and_transfer(v6, 1000000000000000000, v7, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUMP>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PUMP>>(v5);
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

