module 0x7bd8387f35bd0c30f759a7d8bc42c7f06b772043d454461ef174de61b918b7b::azure {
    struct AZURE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZURE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AZURE>(arg0, 9, b"AZURE", b"Azure", b"hold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR64EwsdjnBGuLvSkeTs5a0HkEa9W3a8Ffo7w&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AZURE>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZURE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AZURE>>(v1);
    }

    // decompiled from Move bytecode v6
}

