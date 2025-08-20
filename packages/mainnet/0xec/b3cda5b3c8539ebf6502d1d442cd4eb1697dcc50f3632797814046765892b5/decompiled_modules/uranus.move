module 0xecb3cda5b3c8539ebf6502d1d442cd4eb1697dcc50f3632797814046765892b5::uranus {
    struct URANUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: URANUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<URANUS>(arg0, 9, b"URANUS", b"Uranus Sui", b"$URANUS to Uranus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<URANUS>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<URANUS>>(v2, @0xb83579c646c8cee615afc6d16193ba0d6c81c4cf24df20ce33c99bd84afbaa73);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<URANUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

