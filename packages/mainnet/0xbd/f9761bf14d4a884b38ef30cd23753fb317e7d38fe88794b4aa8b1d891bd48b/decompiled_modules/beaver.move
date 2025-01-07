module 0xbdf9761bf14d4a884b38ef30cd23753fb317e7d38fe88794b4aa8b1d891bd48b::beaver {
    struct BEAVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAVER>(arg0, 6, b"BEAVER", b"BEAVER SUI", b"As the first beaver coin on the SUI Network, Suibeaver is a proud protector of the SUI ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xaf3aae4940a248739ce4964857381fc3f3149a6d05375bfbb2118592907e3bbb_dam_dam_d741640ba2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAVER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEAVER>>(v1);
    }

    // decompiled from Move bytecode v6
}

