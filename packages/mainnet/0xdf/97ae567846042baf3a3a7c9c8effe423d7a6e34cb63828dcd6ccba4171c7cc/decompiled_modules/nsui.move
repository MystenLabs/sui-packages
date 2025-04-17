module 0xdf97ae567846042baf3a3a7c9c8effe423d7a6e34cb63828dcd6ccba4171c7cc::nsui {
    struct NSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NSUI>(arg0, 9, b"Nsui", b"New Sui", x"5355c4b0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8af316795f4d1382e64f1178aeaeae3dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

