module 0xbd94f9a45ad8cf36985346cd81e7c30097abcbc81a116dbe41e64e93f1e1aa22::ssp {
    struct SSP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSP>(arg0, 9, b"SSP", b"BeamMeUpSpork", b"BeamMeUpSpork was created when a mischievous alien decided to beam up a fork instead of a crew member, causing chaos on the Enterprise. The token became a symbol of such incidents and is now a source of endless humor among Star Trek fans.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dstqcb0lj/image/upload/v1739211416/oah7vzzlhi5rj5gygjin.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

