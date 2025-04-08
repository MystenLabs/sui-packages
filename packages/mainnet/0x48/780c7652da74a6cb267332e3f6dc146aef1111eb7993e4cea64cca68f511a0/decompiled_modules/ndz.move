module 0x48780c7652da74a6cb267332e3f6dc146aef1111eb7993e4cea64cca68f511a0::ndz {
    struct NDZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NDZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NDZ>(arg0, 9, b"NDz", b"NaDz", b"the story of handsome boy living in the tawi-tawi trying to know what is crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4ab91aba5ad0f54950b8e04bb0d7a74bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NDZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NDZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

