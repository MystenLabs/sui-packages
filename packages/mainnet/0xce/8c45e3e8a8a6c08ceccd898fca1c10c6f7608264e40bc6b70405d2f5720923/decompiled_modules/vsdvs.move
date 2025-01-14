module 0xce8c45e3e8a8a6c08ceccd898fca1c10c6f7608264e40bc6b70405d2f5720923::vsdvs {
    struct VSDVS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VSDVS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VSDVS>(arg0, 6, b"vsdvs", b"dsvsv", b"svsvs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/330171d8-46b9-45e9-9090-bf2a07c018fb.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VSDVS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VSDVS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

