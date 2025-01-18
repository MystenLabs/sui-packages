module 0x94b318921e3b77b755f3bc445d3b883ca852796c331127a0b28cbd4036fc41d3::rush {
    struct RUSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUSH>(arg0, 9, b"RUSH", b"Rush Hour 3", b"Coin representing the movie rush hour 3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p166593_p_v10_as.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RUSH>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUSH>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

