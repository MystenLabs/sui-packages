module 0x33d178a16b7d2e0a4f7f15826e6ec21f62c41f60c07045683c08f787e61861e1::len {
    struct LEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEN>(arg0, 6, b"LEN", b"LenSassamanSui", b"Creator of $BTC  Join the $LEN Revolution!  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/foto_logo_33350589a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

