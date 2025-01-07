module 0x64c4df110a2dfeafe1dc2e2df2b2e2062031013ede47cbfa86d64775d7f3844::soing {
    struct SOING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOING>(arg0, 6, b"SOING", b"Sui Soing", b"Lots going on behind the scenes over here at $SOING!  There is so much to learn and do and we are so excited to set out on this adventure we call the SUI ecosystem!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000056513_1319374b59.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOING>>(v1);
    }

    // decompiled from Move bytecode v6
}

