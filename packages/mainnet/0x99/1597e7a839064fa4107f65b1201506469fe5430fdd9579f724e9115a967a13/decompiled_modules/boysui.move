module 0x991597e7a839064fa4107f65b1201506469fe5430fdd9579f724e9115a967a13::boysui {
    struct BOYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOYSUI>(arg0, 6, b"Boysui", b"Boy sui", b"From a Boy in the sea to KING OF THE SEAS !COME CONTROL THE WATERS WITH HIM AND PUT HIM IN THE PLACE THAT HE BELONGS . KING OF SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014465_6d59f2e78d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

