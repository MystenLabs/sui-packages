module 0x74bf429c2aa09260f4ae43cdb9fc3d5f06a98638ff3f24deb4f44e075afafbc7::fyman {
    struct FYMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FYMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FYMAN>(arg0, 6, b"FYMAN", b"Flying Dutchman", b"The  flying Dutchman a pirate ghost led by a cute cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_00_15_17_88a9564c81.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FYMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FYMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

