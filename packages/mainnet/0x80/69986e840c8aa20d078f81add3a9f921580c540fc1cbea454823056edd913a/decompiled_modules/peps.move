module 0x8069986e840c8aa20d078f81add3a9f921580c540fc1cbea454823056edd913a::peps {
    struct PEPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPS>(arg0, 6, b"PEPS", b"PEPS Singer", x"4e657720506570732070726f6a65637420323032353a0a53746172746564206f6666696369616c20666972737420736561736f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5062_536ca10328.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

