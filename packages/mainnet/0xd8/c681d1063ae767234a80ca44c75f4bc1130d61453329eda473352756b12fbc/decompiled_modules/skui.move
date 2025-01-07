module 0xd8c681d1063ae767234a80ca44c75f4bc1130d61453329eda473352756b12fbc::skui {
    struct SKUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKUI>(arg0, 6, b"SKUI", b"Kosher Sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.icvcertificationindia.com/wp-content/uploads/2021/03/kosher.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SKUI>(&mut v2, 718718719000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

