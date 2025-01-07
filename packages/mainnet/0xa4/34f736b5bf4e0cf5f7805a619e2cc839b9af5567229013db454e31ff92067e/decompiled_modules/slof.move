module 0xa434f736b5bf4e0cf5f7805a619e2cc839b9af5567229013db454e31ff92067e::slof {
    struct SLOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOF>(arg0, 6, b"SLOF", b"Sloth & Wolf", x"534c4f463d536c6f74682b576f6c660a0a536c6f74683a20416d2049206120646f67653f20200a576f6c663a204e6f702c20796f7520617265206120636174652e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DLT_7_A_Kqz_400x400_e4dee43d52.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

