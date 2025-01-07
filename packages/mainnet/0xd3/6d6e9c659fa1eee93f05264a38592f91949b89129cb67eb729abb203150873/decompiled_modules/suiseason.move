module 0xd36d6e9c659fa1eee93f05264a38592f91949b89129cb67eb729abb203150873::suiseason {
    struct SUISEASON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISEASON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISEASON>(arg0, 6, b"SON", b"Suiseason", b"We are leader of the sui season", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1746788809420029952/D9IPS4UP_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISEASON>>(v1);
        0x2::coin::mint_and_transfer<SUISEASON>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISEASON>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun reounceownership(arg0: 0x2::coin::TreasuryCap<SUISEASON>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISEASON>>(arg0, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v6
}

