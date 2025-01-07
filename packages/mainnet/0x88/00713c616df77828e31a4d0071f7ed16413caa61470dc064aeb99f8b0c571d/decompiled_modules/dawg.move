module 0x8800713c616df77828e31a4d0071f7ed16413caa61470dc064aeb99f8b0c571d::dawg {
    struct DAWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAWG>(arg0, 6, b"DAWG", b"Dawg Token", b"@Dawg_official_", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hp_Xot_R_Ih_400x400_38765afaf6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAWG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAWG>>(v1);
    }

    // decompiled from Move bytecode v6
}

