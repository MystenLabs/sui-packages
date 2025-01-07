module 0x881fc5481f34e1e7500a4293d2ca900f5885aa9f940a1bfbcc1ccbc533bfb91b::mrt {
    struct MRT has drop {
        dummy_field: bool,
    }

    struct TaxCoin has key {
        id: 0x2::object::UID,
        tax_receiver: address,
        tax_percentage: u16,
        balance: 0x2::balance::Balance<MRT>,
    }

    public fun take<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::take<T0>(arg0, arg1 * 92 / 100, arg2)
    }

    public fun changeTax(arg0: &0x2::coin::TreasuryCap<MRT>, arg1: &mut TaxCoin, arg2: address, arg3: u16) {
        arg1.tax_receiver = arg2;
        arg1.tax_percentage = arg3;
    }

    public fun getTax(arg0: &TaxCoin) : u16 {
        arg0.tax_percentage
    }

    fun init(arg0: MRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRT>(arg0, 6, b"MRT03", b"MRT token", b"this is my token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1745384206006669312/fi1rMGEb_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MRT>>(v1);
        0x2::coin::mint_and_transfer<MRT>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRT>>(v2, 0x2::tx_context::sender(arg1));
        let v3 = TaxCoin{
            id             : 0x2::object::new(arg1),
            tax_receiver   : 0x2::tx_context::sender(arg1),
            tax_percentage : 1000,
            balance        : 0x2::balance::zero<MRT>(),
        };
        0x2::transfer::share_object<TaxCoin>(v3);
    }

    public entry fun reounceownership(arg0: 0x2::coin::TreasuryCap<MRT>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRT>>(arg0, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v6
}

