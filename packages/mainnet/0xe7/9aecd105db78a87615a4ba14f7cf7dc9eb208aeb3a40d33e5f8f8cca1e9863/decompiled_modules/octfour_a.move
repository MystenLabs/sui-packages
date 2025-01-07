module 0xe79aecd105db78a87615a4ba14f7cf7dc9eb208aeb3a40d33e5f8f8cca1e9863::octfour_a {
    struct OCTFOUR_A has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTFOUR_A, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTFOUR_A>(arg0, 9, b"OCTFOUR_A", b"PUFFY", b"roll the dice", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OCTFOUR_A>(&mut v2, 3000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTFOUR_A>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTFOUR_A>>(v1);
    }

    // decompiled from Move bytecode v6
}

