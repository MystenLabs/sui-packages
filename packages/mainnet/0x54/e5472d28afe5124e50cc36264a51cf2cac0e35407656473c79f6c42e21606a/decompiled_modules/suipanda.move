module 0x54e5472d28afe5124e50cc36264a51cf2cac0e35407656473c79f6c42e21606a::suipanda {
    struct SUIPANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPANDA>(arg0, 6, b"Suipanda", b"Pandasui", b"Panda..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000905951_8343efc8fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPANDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPANDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

