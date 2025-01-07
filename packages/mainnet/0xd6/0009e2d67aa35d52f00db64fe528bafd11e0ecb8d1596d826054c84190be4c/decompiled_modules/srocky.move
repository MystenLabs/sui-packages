module 0xd60009e2d67aa35d52f00db64fe528bafd11e0ecb8d1596d826054c84190be4c::srocky {
    struct SROCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SROCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SROCKY>(arg0, 6, b"SROCKY", b"SUI ROCKY", x"2453524f434b592c2074686520746f7020646f67206f6e205355492e200a0a2453524f434b592069732074686520637574652070757020796f75206d61792068617665207365656e20706f7070696e672075702e0a0a4974206973206d6f7265207468616e206a7573742061206d656d6520636f696e202d206974732061206d6f76656d656e74", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SROCKY_2_f84b276fb6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SROCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SROCKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

