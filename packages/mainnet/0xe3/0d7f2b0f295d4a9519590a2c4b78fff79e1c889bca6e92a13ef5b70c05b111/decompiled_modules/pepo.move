module 0xe30d7f2b0f295d4a9519590a2c4b78fff79e1c889bca6e92a13ef5b70c05b111::pepo {
    struct PEPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPO>(arg0, 6, b"PEPO", b"PEPEPO", b"Pepe: 'Why take a spaceship when youve got a hippo?' Next stop: the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f8de8fea_901a_4b6c_a73e_27a76c8a5b1f_4d583c211e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

