module 0xe9e901b56f4b81efcf5a9af093ad69a52313077545c4b06f4cd895deb64d70d0::bbm {
    struct BBM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBM>(arg0, 6, b"BBM", b"Barre Babam", b"Meeeeeeee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/462504647_3779053745697041_8424338457601981064_n_35869d7403.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBM>>(v1);
    }

    // decompiled from Move bytecode v6
}

