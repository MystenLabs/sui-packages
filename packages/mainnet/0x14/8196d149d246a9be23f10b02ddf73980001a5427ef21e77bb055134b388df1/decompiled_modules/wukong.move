module 0x148196d149d246a9be23f10b02ddf73980001a5427ef21e77bb055134b388df1::wukong {
    struct WUKONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUKONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUKONG>(arg0, 6, b"Wukong", b"WukongSui", b"Adorable but care of his disguise", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731787442178.PNG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WUKONG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUKONG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

