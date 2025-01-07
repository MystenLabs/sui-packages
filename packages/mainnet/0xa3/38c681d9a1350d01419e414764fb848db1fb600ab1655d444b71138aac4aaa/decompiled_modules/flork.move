module 0xa338c681d9a1350d01419e414764fb848db1fb600ab1655d444b71138aac4aaa::flork {
    struct FLORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLORK>(arg0, 6, b"Flork", b"Flork On Sui", b"First Flork On Sui: https://florkonsui.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gif2_3b5defb8e3.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

