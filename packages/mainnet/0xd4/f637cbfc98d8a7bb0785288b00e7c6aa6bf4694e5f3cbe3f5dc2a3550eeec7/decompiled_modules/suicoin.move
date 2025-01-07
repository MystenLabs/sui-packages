module 0xd4f637cbfc98d8a7bb0785288b00e7c6aa6bf4694e5f3cbe3f5dc2a3550eeec7::suicoin {
    struct SUICOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICOIN>(arg0, 9, b"SUICOIN", b"Sui Coin", b"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum at tortor lectus. Aenean enim orci, volutpat a sagittis eu, tincidunt ut est. Duis consequat odio metus, vitae pretium augue pulvinar id. Quisque vulputate blandit tincidunt. Sed vulputate auctor pellentesque. Donec faucibus erat quis velit ultrices, faucibus pharetra nisl accumsan. Morbi aliquet purus justo, sed aliquet purus imperdiet ut. Vivamus luctus in mauris ac ultricies. Vivamus id mauris justo.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/425552d0ab342fe9026a10c964b11f22blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

