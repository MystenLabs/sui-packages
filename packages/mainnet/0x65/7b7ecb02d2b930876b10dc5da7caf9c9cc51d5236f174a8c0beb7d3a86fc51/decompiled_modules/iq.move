module 0x657b7ecb02d2b930876b10dc5da7caf9c9cc51d5236f174a8c0beb7d3a86fc51::iq {
    struct IQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: IQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IQ>(arg0, 9, b"rack", b"racoon", b"wet racoon trump nigger", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media.istockphoto.com/id/1154370446/photo/funny-raccoon-in-green-sunglasses-showing-a-rock-gesture-isolated-on-white-background.jpg?s=612x612&w=0&k=20&c=kkZiaB9Q-GbY5gjf6WWURzEpLzNrpjZp_tn09GB21bI=")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<IQ>>(0x2::coin::mint<IQ>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<IQ>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

