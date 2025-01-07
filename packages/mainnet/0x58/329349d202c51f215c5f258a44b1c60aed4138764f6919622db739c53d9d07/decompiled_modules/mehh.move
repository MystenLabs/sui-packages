module 0x58329349d202c51f215c5f258a44b1c60aed4138764f6919622db739c53d9d07::mehh {
    struct MEHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEHH>(arg0, 9, b"MEHH", b"Check Check", b"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam at efficitur libero. Pellentesque eleifend porta mauris accumsan porttitor. Mauris tincidunt sed orci pretium dignissim. Ut a nisi eu tellus sagittis laoreet sed vel ex. Suspendisse potenti. Suspendisse ut nunc fringilla, rhoncus tellus a, aliquet risus. Morbi eros sem, fermentum in mauris vel, consectetur volutpat magna. Vestibulum porta, ipsum a condimentum mattis, nunc lacus pulvinar lorem, vitae varius turpis turpis et massa. Vivamus lacinia purus quis luctus vulputate. Aliquam vehicula vel sapien quis lacinia. Vestibulum porta feugiat mi at finibus. Vestibulum non elementum nunc, vel pharetra diam. Mauris commodo mauris non ante ultricies, id lobortis lacus placerat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/44241555db95aa825d383f57d5d7de70blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEHH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEHH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

