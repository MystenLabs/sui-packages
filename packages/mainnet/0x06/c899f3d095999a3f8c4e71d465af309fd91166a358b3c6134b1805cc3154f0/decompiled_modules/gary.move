module 0x6c899f3d095999a3f8c4e71d465af309fd91166a358b3c6134b1805cc3154f0::gary {
    struct GARY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARY>(arg0, 6, b"GARY", b"Gary The PuppyShark", b"Hi frens, im Gary The PuppyShark and im here to build a flock that can take over the SUI Network, i gibe protec to all my flock members, join my telegram group and build the biggest community on SUI, and take over this bis!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_A_jabbb_9b465e2bf1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GARY>>(v1);
    }

    // decompiled from Move bytecode v6
}

