module 0x65f822c55d40d520965ff887e00db7334807e14c8dd68f00a2bdfcd4bed933a0::asuiki {
    struct ASUIKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASUIKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASUIKI>(arg0, 6, b"Asuiki", b"ASUIKI", b"Join the asuiki and get a chance to get wl for the upcoming NFT collection. Have a nice time in the community until the nft collection is released", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c_ecd5a134ec.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASUIKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASUIKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

