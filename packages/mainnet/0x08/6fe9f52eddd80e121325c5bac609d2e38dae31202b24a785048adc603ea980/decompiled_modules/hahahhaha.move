module 0x86fe9f52eddd80e121325c5bac609d2e38dae31202b24a785048adc603ea980::hahahhaha {
    struct HAHAHHAHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAHAHHAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAHAHHAHA>(arg0, 9, b"HAHAHHAHA", b"BOO", b"Official token of boo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.wikia.nocookie.net/diceblock/images/d/da/600px-BooNSMBWii-1-.png/revision/latest/scale-to-width-down/250?cb=20181109170546")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HAHAHHAHA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAHAHHAHA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAHAHHAHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

