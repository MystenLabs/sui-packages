module 0x834de2bac99ddbd313706be7e040a5315f82d45f913ee61f9fdeb72e826d2f02::smurpe {
    struct SMURPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMURPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMURPE>(arg0, 6, b"SMURPE", b"Smurf Pepe", b"Small in size, big on Sui dreams! Half Smurf, half Pepe, all about magic!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/smurf_pepe_logo_c3a8aa1c30.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMURPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMURPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

