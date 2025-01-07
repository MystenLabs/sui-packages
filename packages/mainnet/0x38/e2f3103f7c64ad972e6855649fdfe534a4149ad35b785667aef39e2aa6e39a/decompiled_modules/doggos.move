module 0x38e2f3103f7c64ad972e6855649fdfe534a4149ad35b785667aef39e2aa6e39a::doggos {
    struct DOGGOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGGOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGGOS>(arg0, 6, b"DOGGOS", b"Sui Doggos", b"Doggos had a Sui Coke", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/doggos_202d59d991.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGGOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGGOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

