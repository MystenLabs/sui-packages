module 0x22651097d5c961a5af33760e3af3ab46b939091f2e5f5800747ff622095ddd42::harrs {
    struct HARRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARRS>(arg0, 6, b"HARRS", b"harrs", x"244841525249532069732061206d656d65636f696e2063656e74657265642061726f756e64204b616d616c61204861727269730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000365_226e7eef21.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HARRS>>(v1);
    }

    // decompiled from Move bytecode v6
}

