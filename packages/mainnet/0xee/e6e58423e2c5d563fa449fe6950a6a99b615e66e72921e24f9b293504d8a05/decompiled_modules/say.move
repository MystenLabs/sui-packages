module 0xeee6e58423e2c5d563fa449fe6950a6a99b615e66e72921e24f9b293504d8a05::say {
    struct SAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAY>(arg0, 6, b"SAY", b"Suiallday", b"Premium content and deep insight about Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2k_Vujfip_400x400_a082cdfdf0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

