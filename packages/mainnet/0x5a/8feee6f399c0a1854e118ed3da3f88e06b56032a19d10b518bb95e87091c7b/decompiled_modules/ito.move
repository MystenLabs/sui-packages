module 0x5a8feee6f399c0a1854e118ed3da3f88e06b56032a19d10b518bb95e87091c7b::ito {
    struct ITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ITO>(arg0, 6, b"ITO", b"Ito", x"2449544f3a20546865204d656d6520546f6b656e20526f6f74656420696e20746865204f726967696e73206f6620244e6569726f20616e64207468652024444f4745204c65676163790a0a2449544f20776173206c61756e63686564206f6e204a756c792032382c2032303234206279207468652073616d65206465706c6f796572206f66200a406e6569726f65746863746f0a20616e642068617320616e206f726967696e2073746f7279207468617420696e7465727477696e6573207769746820626f7468207468652066616d6f757320444f4745206d656d6520616e6420697473207369626c696e672c204e6569726f2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/13_62bbeb58b9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ITO>>(v1);
    }

    // decompiled from Move bytecode v6
}

