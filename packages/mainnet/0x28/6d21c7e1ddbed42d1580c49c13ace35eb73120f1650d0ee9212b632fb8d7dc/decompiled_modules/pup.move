module 0x286d21c7e1ddbed42d1580c49c13ace35eb73120f1650d0ee9212b632fb8d7dc::pup {
    struct PUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUP>(arg0, 6, b"PUP", b"SuiPup", b"up - the actual, final sui $pup", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mwt_Lhvr_D_400x400_f7d06a9e38.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

