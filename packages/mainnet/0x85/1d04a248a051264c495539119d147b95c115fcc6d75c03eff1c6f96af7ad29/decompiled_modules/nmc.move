module 0x851d04a248a051264c495539119d147b95c115fcc6d75c03eff1c6f96af7ad29::nmc {
    struct NMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NMC>(arg0, 6, b"NMC", b"Namecoin", b"Building a censorship free web using Bitcoin technology.  This official account is controlled by the Namecoin developer team.  https://namecoin.bit/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/name_acb9a93bbc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

