module 0xd96737a505733f606d366429c3a0600147a795ec55cd98ec189d1f13dd126873::bcat {
    struct BCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCAT>(arg0, 9, b"BCAT", b"Baby Cat", b"My lovely cat asked me to put him on the sui blockchain. His name is Baby Cat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5f48da0c80ca0d7431a01769b2fe713ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

