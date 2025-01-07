module 0x84f17e2355c8153e20eda005b99ea38e16015dcf15681a3a7c0cb16e40b87c23::snv {
    struct SNV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNV>(arg0, 6, b"SNV", b"SuiNova", b" A revolutionary cryptocurrency designed to bring innovation and speed to decentralized finance on the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e8bbfbdf_67c0_4b97_a92a_98896aa368d7_7ea18fe753.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNV>>(v1);
    }

    // decompiled from Move bytecode v6
}

