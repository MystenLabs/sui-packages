module 0x777bf25ff64a643dec0f95977452cc569fe0d0ba664fcb2b0d46ec293592575c::mamoon {
    struct MAMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAMOON>(arg0, 6, b"MAMOON", b"Sui Mamoon", x"4865792120496d204d616d6f6f6e2c20746865206d616d6d6f74682077686f206c65667420456172746820746f206d6f6f6e73686f7420746f20746865204d6f6f6e2e205768696c65206d792068657264207761732062757379206772617a696e67206c696b652069742077617320612062656172206d61726b65742c2049206275696c74206120726f636b65742028646f6e742061736b292c20616e64206e6f7720496d206c6976696e672066726565210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049408_465414fb6f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

