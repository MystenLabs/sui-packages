module 0xc92d033fdb8831d0b058f7ea32dc3eb2908f8def8c943c0d7f429452e8425cbb::suibzero {
    struct SUIBZERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBZERO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBZERO>(arg0, 6, b"SUIBZERO", b"Suib-zero", b"Sub-Zero is a fictional character in the Mortal Kombat fighting game franchise by Midway Games and NetherRealm Studios. A warrior from the fictional Lin Kuei clan, he possesses ability to control ice in many forms.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIBZERO_770571b9b5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBZERO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBZERO>>(v1);
    }

    // decompiled from Move bytecode v6
}

