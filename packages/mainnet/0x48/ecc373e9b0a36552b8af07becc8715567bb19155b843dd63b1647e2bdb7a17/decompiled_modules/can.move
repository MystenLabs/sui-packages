module 0x48ecc373e9b0a36552b8af07becc8715567bb19155b843dd63b1647e2bdb7a17::can {
    struct CAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAN>(arg0, 9, b"CAN", b"CANCOIN", b"This coin aims at telling you still can do all  those which had seem impossibl earlier. You should not give up regardless, just put in the the requisite work demanded and your success awaits you at the end of the tunnel.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5b1d8e42d706b87822f349779d8cd4d5blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

