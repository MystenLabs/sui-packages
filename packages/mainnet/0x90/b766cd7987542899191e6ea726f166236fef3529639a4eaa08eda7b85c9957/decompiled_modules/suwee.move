module 0x90b766cd7987542899191e6ea726f166236fef3529639a4eaa08eda7b85c9957::suwee {
    struct SUWEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUWEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUWEE>(arg0, 6, b"SUWEE", b"SUWEE THE PIG", x"5355574545206973206120646567656e65726174652070696720776974682067616d626c696e6720697373756573206f6e207468652053554920626c6f636b636861696e0a0a535555555555555745454545454545452021212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008314_8e3be58099.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUWEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUWEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

