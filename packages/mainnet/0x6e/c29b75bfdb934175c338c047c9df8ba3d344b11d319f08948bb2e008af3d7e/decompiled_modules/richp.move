module 0x6ec29b75bfdb934175c338c047c9df8ba3d344b11d319f08948bb2e008af3d7e::richp {
    struct RICHP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICHP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICHP>(arg0, 6, b"RICHP", b"Crazy Rich Piggy", b"This pig is swag af, with his fame he has achieved financial freedom. with a kind heart he likes to make donations to some beggars. LET'S PARTICIPATE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/send_it_c103f8e65a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICHP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RICHP>>(v1);
    }

    // decompiled from Move bytecode v6
}

