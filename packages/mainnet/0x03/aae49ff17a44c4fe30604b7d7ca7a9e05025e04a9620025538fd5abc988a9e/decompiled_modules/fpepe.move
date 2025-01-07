module 0x3aae49ff17a44c4fe30604b7d7ca7a9e05025e04a9620025538fd5abc988a9e::fpepe {
    struct FPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FPEPE>(arg0, 6, b"FPEPE", b"Father Pepe On Sui", b"$FPEPE The Integrity Coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/iurp2it_H_400x400_48f131acac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

