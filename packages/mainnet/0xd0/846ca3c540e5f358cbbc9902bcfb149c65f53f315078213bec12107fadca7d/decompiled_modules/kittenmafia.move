module 0xd0846ca3c540e5f358cbbc9902bcfb149c65f53f315078213bec12107fadca7d::kittenmafia {
    struct KITTENMAFIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KITTENMAFIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KITTENMAFIA>(arg0, 6, b"KITTENMAFIA", b"Cat Mafia Of Sui", b"Cat Mafia Gang Full Of Fucking Negros", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catmaff_b20ed00211.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KITTENMAFIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KITTENMAFIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

