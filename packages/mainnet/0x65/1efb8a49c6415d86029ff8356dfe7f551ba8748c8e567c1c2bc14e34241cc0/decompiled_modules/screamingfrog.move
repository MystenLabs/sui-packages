module 0x651efb8a49c6415d86029ff8356dfe7f551ba8748c8e567c1c2bc14e34241cc0::screamingfrog {
    struct SCREAMINGFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCREAMINGFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCREAMINGFROG>(arg0, 6, b"ScreamingFrog", b"screaming frog", b"screaming cute frog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bildschirmfoto_2024_09_27_um_18_06_05_6778e70147.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCREAMINGFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCREAMINGFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

