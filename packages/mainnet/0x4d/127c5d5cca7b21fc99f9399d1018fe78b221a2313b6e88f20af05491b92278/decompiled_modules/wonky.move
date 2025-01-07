module 0x4d127c5d5cca7b21fc99f9399d1018fe78b221a2313b6e88f20af05491b92278::wonky {
    struct WONKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WONKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WONKY>(arg0, 6, b"WONKY", b"Wonky Cat", b"A Pink Cat Having Fun And Doing Stupid Things.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GQ_Hrtd_Ri_400x400_1a17238e71.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WONKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WONKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

