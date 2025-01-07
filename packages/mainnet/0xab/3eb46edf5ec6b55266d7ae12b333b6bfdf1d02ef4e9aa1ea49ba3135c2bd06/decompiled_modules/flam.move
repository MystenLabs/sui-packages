module 0xab3eb46edf5ec6b55266d7ae12b333b6bfdf1d02ef4e9aa1ea49ba3135c2bd06::flam {
    struct FLAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLAM>(arg0, 6, b"FLAM", b"FLAM SUI", b"Flam is not your typical Flamingo, he stands on 2 feet wearing his sneaks. His Flamboyance is unmeasurable. Flam Is creating a whole new category on SUI. No dogs, no Cats, No blub, no bull shit. Just a Dope ass pink Bird.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000114657_ac6cb5df35.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

