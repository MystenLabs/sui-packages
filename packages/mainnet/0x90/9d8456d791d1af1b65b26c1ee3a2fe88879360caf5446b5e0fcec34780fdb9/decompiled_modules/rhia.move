module 0x909d8456d791d1af1b65b26c1ee3a2fe88879360caf5446b5e0fcec34780fdb9::rhia {
    struct RHIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHIA>(arg0, 6, b"RHIA", b"rhia", b"wadsdawdas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/415762975_403520668918853_7746619568036198126_n_59cf379d5a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RHIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

