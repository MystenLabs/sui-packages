module 0x50725ee57e44be783929e4d16151fbf1513930b4fdb794385099440a053ada94::trout {
    struct TROUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROUT>(arg0, 6, b"TROUT", b"Trouser Trout", b"Only Chads with Trouser Trouts here.....Do not enter if hung like a fruit bat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Trout_85e37d892a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TROUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

