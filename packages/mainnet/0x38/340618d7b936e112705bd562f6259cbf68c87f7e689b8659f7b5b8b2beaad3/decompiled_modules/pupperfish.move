module 0x38340618d7b936e112705bd562f6259cbf68c87f7e689b8659f7b5b8b2beaad3::pupperfish {
    struct PUPPERFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPPERFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPPERFISH>(arg0, 6, b"PUPPERFISH", b"pupperfish coin", b"\"pupper+fish\" Yall gonna make this one a coin too ?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20240914085445_1095f03670.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPPERFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUPPERFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

