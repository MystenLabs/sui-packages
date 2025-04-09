module 0xfadc3b0fd8aea6aa485ab48271c957922396ab4984a7045da570cf836ed895cc::root_sui {
    struct ROOT_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROOT_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROOT_SUI>(arg0, 9, b"rootSUI", b"Rootlets Staked SUI", b"The most rootarded LST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcStg96-vbJXvWLEwa4J6R2fUJKz_nGtaCaGvcOelVbi1R-ZuclBeOD6L4FjB3w3zDnksmKTdOYq8ZTNzq5vJtWvJL_WZqii1HhRNi53HAoi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROOT_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROOT_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

