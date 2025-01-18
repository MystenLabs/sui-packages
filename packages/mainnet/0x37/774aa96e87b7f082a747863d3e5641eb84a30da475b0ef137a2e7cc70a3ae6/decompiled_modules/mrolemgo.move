module 0x37774aa96e87b7f082a747863d3e5641eb84a30da475b0ef137a2e7cc70a3ae6::mrolemgo {
    struct MROLEMGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MROLEMGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MROLEMGO>(arg0, 6, b"MrOlemgo", b"Mr Olemgo", x"65766572796f6e652033207375692070756d702e200a6465706f73697420332073756920616e6420666f726765742e2053656520796f7520696e207468652073746f636b206d61726b65742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020461_e185cc63fd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MROLEMGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MROLEMGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

