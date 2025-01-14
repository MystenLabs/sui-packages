module 0x4eeabe6af2e43d7894c4b08b04d4d58c4913265d93f343b1f5492b7bca983a8a::catlia {
    struct CATLIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATLIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATLIA>(arg0, 6, b"CATlia", b"CAT Lia", b"CATlia bost marker", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018375_84bd2dc9fa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATLIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATLIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

