module 0xecefa502a3e5b2138fc91f4533d7ae1e88dde22088abfc3e47ed2a8ebd5e854d::suiward {
    struct SUIWARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWARD>(arg0, 6, b"SUIWARD", b"SUIward Tentacles", b"WHO LIVES IN THE PINEAPPLE UNDER THE SEA? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9108_4092e6e195.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

