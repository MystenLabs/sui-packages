module 0x1124287d920a45156753d608bb74197c719fa7fa0da43c7cb0f4e42c4a8e3310::mat {
    struct MAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAT>(arg0, 6, b"Mat", b"MadCat", b"The maddest , angriest memecoin ready to claw its way to the top.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Luffy_7858d84f9d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

