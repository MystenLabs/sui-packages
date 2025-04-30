module 0x5086bfd14a1d0a99694e5a7915e604c5dc71d1ea2b1aa9b09a92bf614c81a025::rn {
    struct RN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RN>(arg0, 9, b"RN", b"Rainbow", b"Feel free with beautiful colors ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/248d4a7bbcf0b566a078bddded9303b2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

