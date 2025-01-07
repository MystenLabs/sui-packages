module 0x30567838dc95b15c3e190e965b4a21e5cdda63401fa8fb2d9a7a4beda67ba6f9::octo {
    struct OCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTO>(arg0, 6, b"OCTO", b"Octo Labs", b"We need YOU to help build the strongest community in crypto!  Join us now, stake your claim, and ride the wave with $OCTO. Together, were creating a powerhouse in DeFi and NFTs! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ockto_4ebbfbf9cd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

