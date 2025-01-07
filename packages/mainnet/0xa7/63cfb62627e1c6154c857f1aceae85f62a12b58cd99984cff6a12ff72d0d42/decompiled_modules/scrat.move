module 0xa763cfb62627e1c6154c857f1aceae85f62a12b58cd99984cff6a12ff72d0d42::scrat {
    struct SCRAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCRAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCRAT>(arg0, 6, b"SCRAT", b"Scrat Token", x"68692c20496d20245343524154212068616c6620737175697272656c2c2068616c66207261742c20666f726576657220696e2070757273756974206f66206d792072756e61776179206261672e0a0a687474703a2f2f73637261746f6e7375692e78797a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/avatar_7f99e29198.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCRAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCRAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

