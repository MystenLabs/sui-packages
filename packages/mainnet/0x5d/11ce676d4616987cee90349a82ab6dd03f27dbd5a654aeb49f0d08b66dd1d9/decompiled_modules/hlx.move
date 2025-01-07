module 0x5d11ce676d4616987cee90349a82ab6dd03f27dbd5a654aeb49f0d08b66dd1d9::hlx {
    struct HLX has drop {
        dummy_field: bool,
    }

    fun init(arg0: HLX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HLX>(arg0, 6, b"HLX", b"Le trou de ball d'helixy", b".", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/14_192754d7b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HLX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HLX>>(v1);
    }

    // decompiled from Move bytecode v6
}

