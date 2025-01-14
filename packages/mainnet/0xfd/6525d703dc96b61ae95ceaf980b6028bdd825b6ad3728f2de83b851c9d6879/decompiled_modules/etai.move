module 0xfd6525d703dc96b61ae95ceaf980b6028bdd825b6ad3728f2de83b851c9d6879::etai {
    struct ETAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETAI>(arg0, 6, b"ETAI", b"Eye Tech AI", b"Unleash the Power of Data Visualization with Eye Technology.  Powered by $ETAI token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/loyaz_Mp_400x400_edbcc7822f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

